import 'package:package_info/package_info.dart';

class Version {
  final String version;
  final int versionCode;

  Version(PackageInfo info)
      : version = info.version,
        versionCode = int.parse(info.buildNumber);

  getFullVersion() {
    return "$version ($versionCode)";
  }
}
