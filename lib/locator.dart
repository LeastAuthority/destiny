import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:destiny/settings.dart';
import 'package:destiny/version.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

void register(GetIt getIt, Config defaults) {
  getIt.registerSingletonAsync(() => StreamingSharedPreferences.instance);

  getIt.registerSingletonAsync(() => PackageInfo.fromPlatform());

  getIt.registerSingletonWithDependencies(
    () => AppSettings(getIt<StreamingSharedPreferences>(), defaults),
    dependsOn: [StreamingSharedPreferences],
  );

  getIt.registerSingletonWithDependencies(
    () => Version(getIt<PackageInfo>()),
    dependsOn: [PackageInfo],
  );
}
