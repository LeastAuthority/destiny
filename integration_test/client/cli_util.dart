import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

final wormholeWilliamPath =
    path.join('.', 'dart_wormhole_william', 'wormhole-william');
var testFileSrcDir;
final testFileDestDir = path.join(testFileSrcDir, 'test_dest');
final goCliPath = path.join(testFileDestDir, 'ww_cli.exe');
final goCliFromTestFileDestPath =
    path.join('.', path.relative(goCliPath, from: testFileDestDir));

String sendTextGo(String text) {
  // TODO: read code from stdout (?)
  const code = "7-guitarist-revenge";
  final res = Process.run(
    goCliFromTestFileDestPath,
    [
      'send',
      '--relay-url',
      'ws://localhost:4000/v1',
      '--code',
      code,
      '--text',
      text,
    ],
    workingDirectory: testFileDestDir,
  );
  res.then((_res) {
    print(_res.stdout);
  });
  return code;
}

String recvTextGo(String code) {
  final res = Process.runSync(
    goCliFromTestFileDestPath,
    [
      'receive',
      '--relay-url',
      'ws://localhost:4000/v1',
      code,
    ],
    workingDirectory: testFileDestDir,
  );
  return res.stdout.toString().trimRight();
}

Future<File> recvFileGo(String code, String filename) async {
  final done = Completer<File>();
  final recvProcess = await Process.start(
    goCliFromTestFileDestPath,
    [
      'receive',
      code,
      '--relay-url',
      'ws://localhost:4000/v1',
      '--transit-helper',
      'tcp:localhost:4001',
    ],
    workingDirectory: testFileDestDir,
  );

  recvProcess.exitCode.then((exitCode) {
    if (exitCode != 0) {
      print('Error running `ww_client.exe receive $code:');
      recvProcess.stderr.listen((lineInts) {
        print(String.fromCharCodes(lineInts));
      });
    }
  });

  recvProcess.stdout.listen((lineInts) {
    final lineString = String.fromCharCodes(lineInts);
    if (lineString.contains('ok? (y/N):')) {
      recvProcess.stdin.write('y\n');
    }
  });

  await recvProcess.exitCode;
  return File(path.join(testFileDestDir, filename));
}

Future<String> sendFileGo(String filename) async {
  final filePath = path.join('.', filename);
  final done = Completer<String>();
  final sendProcess = await Process.start(
    path.relative(goCliPath, from: testFileSrcDir),
    [
      'send',
      '--relay-url',
      'ws://localhost:4000/v1',
      '--transit-helper',
      'tcp:localhost:4001',
      filePath,
    ],
    workingDirectory: testFileSrcDir,
  );

  sendProcess.exitCode.then((exitCode) {
    if (exitCode != 0) {
      print('Error running `ww_client.exe send $filePath:');
      sendProcess.stderr.listen((lineInts) {
        print(String.fromCharCodes(lineInts));
      });
    }
  });

  const codePrefix = 'Wormhole code is: ';
  sendProcess.stdout.listen((lineInts) {
    final lineString = String.fromCharCodes(lineInts);
    if (lineString.contains(codePrefix)) {
      final code = lineString.split(codePrefix)[1].trim();
      done.complete(code);
    }
  });

  return done.future;
}

Future<ProcessResult> buildGoCli(String goCliFilesDir) {
  testFileSrcDir = goCliFilesDir;
  final buildOutPath = path.relative(goCliPath, from: wormholeWilliamPath);
  final resFuture = Process.run(
    'go',
    [
      'build',
      '-o',
      buildOutPath,
      '.',
    ],
    workingDirectory: wormholeWilliamPath,
  );

  resFuture.then((res) {
    if (res.stderr != '') {
      print("ERROR running `go build -o $buildOutPath .`:");
      print(res.stderr);
    }
  });

  return resFuture;
}
