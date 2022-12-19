import 'package:package_info_plus/package_info_plus.dart';

class Version {
  final String version;
  final String versionCode;

  Version(PackageInfo info)
      : version = info.version,
        versionCode = info.buildNumber;

  getFullVersion() {
    return "$version" + (versionCode != "" ? " ($versionCode)" : "");
  }
}
