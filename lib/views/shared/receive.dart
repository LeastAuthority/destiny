import 'dart:io' as dartIO;
import 'dart:math';

import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/shared/file_picker.dart';
import 'package:destiny/views/shared/progress.dart';
import 'package:destiny/views/shared/util.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/file.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart' as f;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

import '../../main.dart';
import '../../settings.dart';

enum ReceiveScreenStates {
  FileReceived,
  ReceiveError,
  FileReceiving,
  ReceiveConfirmation,
  Initial,
}

class ReceiveSharedState extends ChangeNotifier {
  String? _code;

  PendingDownload? pendingDownload;

  int? get fileSize => pendingDownload?.size;
  String? get fileName => pendingDownload?.fileName;

  late bool isRequestingConnection = false;

  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  SharedPreferences? prefs;
  late final String? defaultPathForPlatform;
  String? error;
  String? errorMessage;
  String? errorTitle;
  bool selectingFolder = false;
  File? saveAsFile;
  late String? currentDestinationPath = path;

  late final TextEditingController controller = new TextEditingController();

  final appSettings = getIt<AppSettings>();

  void Function() failWith(String errorMessage) {
    return () {
      throw Exception(errorMessage);
    };
  }

  void setState(void Function() change) {
    change();
    notifyListeners();
  }

  late void Function() acceptDownload =
      failWith("No accept download function set");
  late void Function() rejectDownload =
      failWith("No reject download function set");

  late CancelFunc cancelFunc = failWith("No cancel transfer function set");

  String? get path {
    final path = prefs?.get(PATH);

    if (path != null && path is String) {
      return path;
    }

    return defaultPathForPlatform;
  }

  void reset() {
    setState(() {
      _code = null;
      controller.text = '';
      pendingDownload = null;
      isRequestingConnection = false;
      currentState = ReceiveScreenStates.Initial;
      error = null;
      errorMessage = null;
      errorTitle = null;
      saveAsFile = null;
      progress = ProgressSharedState(setState, () {
        currentState = ReceiveScreenStates.FileReceiving;
      });
      currentDestinationPath = path;
      cancelFunc = failWith("No cancel transfer function set");
    });
  }

  ReceiveSharedState() {
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
    });

    if (dartIO.Platform.isAndroid) {
      defaultPathForPlatform = ANDROID_DOWNLOADS_FOLDER_PATH;
    } else if (dartIO.Platform.isIOS) {
      getApplicationDocumentsDirectory().then((downloadsDir) {
        setState(() {
          defaultPathForPlatform = downloadsDir.path;
        });
      });
    } else {
      getDownloadsDirectory().then((downloadsDir) {
        setState(() {
          defaultPathForPlatform = downloadsDir?.path;
        });
      });
    }
  }

  late ProgressSharedState progress = ProgressSharedState(setState, () {
    currentState = ReceiveScreenStates.FileReceiving;
  });

  void codeChanged(String code) {
    setState(() {
      _code = code;
      isRequestingConnection = false;
    });
  }

  static String _tempPath(String prefix) {
    final r = Random();
    int suffix = r.nextInt(1 << 32);
    while (dartIO.File("$prefix.$suffix").existsSync()) {
      suffix = r.nextInt(1 << 32);
    }

    return "$prefix.$suffix";
  }

  void defaultErrorHandler(Object error) {
    this.setState(() {
      this.currentState = ReceiveScreenStates.ReceiveError;
      this.error = '';
      this.errorMessage = error.toString();
      this.errorTitle = SOMETHING_WENT_WRONG;

      if (error is ClientError) {
        switch (error.errorCode) {
          case ErrCodeTransferRejected:
            this.errorTitle = TRANSFER_CANCELLED;
            this.error = YOU_HAVE_CANCELLED_THE_TRANSFER;
            break;
          case ErrCodeTransferCancelled:
            this.errorTitle = TRANSFER_CANCELLED;
            this.error = YOU_HAVE_CANCELLED_THE_TRANSFER;
            break;
          case ErrCodeTransferCancelledBySender:
            this.errorTitle = TRANSFER_CANCELLED_INTERRUPTED;
            this.error = EITHER_THE_TRANSFER_WAS_CANCELLED_BY_SENDER;
            break;
          case ErrCodeWrongCode:
            this.errorTitle = OOPS;
            this.error = SOMETHING_WENT_WRONG_POSSIBLY;
            break;
          case ErrCodeReceiveFileError:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name (case invalid nameplate)
            break;
          case ErrCodeReceiveTextError:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name
            break;
          case ErrCodeConnectionRefused:
            this.errorTitle = OOPS;
            this.error = ERR_CONNECTION_REFUSED;
            break;
          case ErrCodeGenerationFailed:
            this.errorTitle = OOPS;
            this.error = ERR_CONNECTION_REFUSED;
            break;
          default:
            this.errorTitle = SOMETHING_WENT_WRONG;
            // TODO: map error to user friendly name
            break;
        }
      }
    });

    throw error;
  }

  Future<ReceiveFileResult> receive() async {
    if (saveAsFile == null && !(await canWriteToDirectory(path!))) {
      final error = Exception("Permission denied. Could not write to ${path!}");
      defaultErrorHandler(error);
      return Future.error(error);
    }
    late final dartIO.File tempFile;
    this.setState(() {
      isRequestingConnection = true;
    });

    final Client client = createClient();
    return client.recvFile(_code!, progress.progressHandler).then((result) {
      result.done.then((value) async {
        this.setState(() {
          currentState = ReceiveScreenStates.FileReceived;
        });
        if (saveAsFile == null) {
          await tempFile.rename(nonExistingPathFor("$path" +
              dartIO.Platform.pathSeparator +
              "${result.pendingDownload.fileName}"));
        }
      }, onError: defaultErrorHandler);

      this.setState(() {
        currentState = ReceiveScreenStates.ReceiveConfirmation;
        acceptDownload = () {
          controller.text = '';
          if (saveAsFile == null) {
            tempFile = dartIO.File(_tempPath("$path" +
                dartIO.Platform.pathSeparator +
                "${result.pendingDownload.fileName}"));
          }
          var cancelFunc = saveAsFile == null
              ? result.pendingDownload.accept(tempFile.writeOnlyFile())
              : result.pendingDownload.accept(saveAsFile!);
          this.setState(() {
            currentState = ReceiveScreenStates.FileReceiving;
            this.cancelFunc = cancelFunc;
          });
        };
        rejectDownload = () {
          result.pendingDownload.reject();
          reset();
        };
        pendingDownload = result.pendingDownload;
      });

      return result;
    }, onError: defaultErrorHandler);
  }

  Client createClient() => Client(appSettings.config());

  Future<File> _selectSaveDestinationAndroid(String initialFileName) async {
    final uri = await MethodChannel("destiny.android/save_as")
        .invokeMethod<String>(
            "save_as", <String, dynamic>{"filename": initialFileName});

    if (uri != null) {
      return uri.androidUriToWriteOnlyFile();
    } else {
      return Future.error("uri from save as was null");
    }
  }

  void selectSaveDestination(String initialFileName) async {
    try {
      if (selectingFolder) return;

      setState(() {
        selectingFolder = true;
      });

      if (dartIO.Platform.isAndroid) {
        final destinationFile =
            await _selectSaveDestinationAndroid(initialFileName);
        final metadata = await destinationFile.metadata();
        currentDestinationPath = metadata.parentPath!;
        pendingDownload?.fileName = metadata.fileName!;
        setState(() {
          saveAsFile = destinationFile;
        });
      } else {
        final destinationPath =
            await f.FilePicker.platform.saveFile(fileName: initialFileName);
        if (destinationPath == null) {
          throw Exception("Save as dialog returned null");
        }
        final file = await dartIO.File(destinationPath)
            .open(mode: dartIO.FileMode.write);
        final pathParts = destinationPath.split(dartIO.Platform.pathSeparator);
        setState(() {
          pendingDownload?.fileName = pathParts.reversed.first;
          currentDestinationPath = pathParts.reversed
              .skip(1)
              .toList()
              .reversed
              .join(dartIO.Platform.pathSeparator);
          saveAsFile = File(
            write: file.writeFrom,
            close: file.close,
          );
        });
      }

      acceptDownload();
    } finally {
      setState(() {
        selectingFolder = false;
      });
    }
  }

  Widget widgetByState(
      Widget Function() receivingDone,
      Widget Function() receiveError,
      Widget Function() receiveProgress,
      Widget Function() enterCodeUI,
      Widget Function() receiveConfirmation) {
    switch (currentState) {
      case ReceiveScreenStates.Initial:
        return enterCodeUI();
      case ReceiveScreenStates.ReceiveError:
        // Disable Android and iOS screens if failure
        if (dartIO.Platform.isAndroid || dartIO.Platform.isIOS) {
          Wakelock.disable();
        }
        return receiveError();
      case ReceiveScreenStates.ReceiveConfirmation:
        // Keep Android and iOS screens awake after entering code generation till success or failure
        if (dartIO.Platform.isAndroid || dartIO.Platform.isIOS) {
          Wakelock.enable();
        }
        return receiveConfirmation();
      case ReceiveScreenStates.FileReceived:
        // Disable Android and iOS screens if failure
        if (dartIO.Platform.isAndroid || dartIO.Platform.isIOS) {
          Wakelock.disable();
        }
        return receivingDone();
      case ReceiveScreenStates.FileReceiving:
        return receiveProgress();
    }
  }
}
