import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:my_package_web/my_package_web.dart';

void main() {
  const MethodChannel channel = MethodChannel('my_package_web');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await MyPackageWeb.platformVersion, '42');
  });
}
