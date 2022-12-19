import 'package:destiny/version.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<PackageInfo>()])
import 'version_test.mocks.dart';

void main() {
  test('getFullVersion without buildNumber', () {
    var packageInfo = MockPackageInfo();
    when(packageInfo.version).thenReturn("1.2.3");
    when(packageInfo.buildNumber).thenReturn("");

    final result = Version(packageInfo).getFullVersion();

    expect(result, "1.2.3");
  });

  test('getFullVersion with both version components', () {
    var packageInfo = MockPackageInfo();
    when(packageInfo.version).thenReturn("1.2.3");
    when(packageInfo.buildNumber).thenReturn("56");

    final result = Version(packageInfo).getFullVersion();

    expect(result, "1.2.3 (56)");
  });
}
