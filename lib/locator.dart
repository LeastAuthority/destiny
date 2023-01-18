import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:destiny/settings.dart';
import 'package:destiny/version.dart';
import 'package:destiny/views/shared/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

void register(GetIt getIt, Config defaults) {
  if (!GetIt.instance.isRegistered<StreamingSharedPreferences>()) {
    getIt.registerSingletonAsync(() => StreamingSharedPreferences.instance);
  }
  if (!GetIt.instance.isRegistered<PackageInfo>()) {
    getIt.registerSingletonAsync(() => PackageInfo.fromPlatform());
    getIt.registerSingletonWithDependencies(
      () => Version(getIt<PackageInfo>()),
      dependsOn: [PackageInfo],
    );
  }

  if (!GetIt.instance.isRegistered<PathConfig>()) {
    getIt.registerSingletonAsync(() => getPathConfig());

    getIt.registerSingletonWithDependencies(
      () => AppSettings(
          getIt<StreamingSharedPreferences>(), defaults, getIt<PathConfig>()),
      dependsOn: [StreamingSharedPreferences, PathConfig],
    );
  }
}
