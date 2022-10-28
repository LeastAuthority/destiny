import 'package:flutter_test/flutter_test.dart';
import 'package:hello/hello.dart';
import 'package:hello/hello_platform_interface.dart';
import 'package:hello/hello_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockHelloPlatform
    with MockPlatformInterfaceMixin
    implements HelloPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final HelloPlatform initialPlatform = HelloPlatform.instance;

  test('$MethodChannelHello is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelHello>());
  });

  test('getPlatformVersion', () async {
    Hello helloPlugin = Hello();
    MockHelloPlatform fakePlatform = MockHelloPlatform();
    HelloPlatform.instance = fakePlatform;

    expect(await helloPlugin.getPlatformVersion(), '42');
  });
}
