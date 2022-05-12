
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_package_platform_interface/my_package_platform_interface.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const MethodChannel _channel = MethodChannel('plugins.mydomain.com/my_package_ios');

class MyPackageIosPlugin extends MyPackagePlatform {

  static final Object _token = Object();

  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith() {
    MyPackagePlatform.instance = MyPackageIosPlugin();
  }

  // static const MethodChannel _channel = MethodChannel('my_package_ios');
  // static const MethodChannel _channel =
  // MethodChannel('plugins.flutter.io/url_launcher_ios');

  @override
  Future<bool> canLaunch(String url) {
    return _channel.invokeMethod<bool>(
      'canLaunch',
      <String, Object>{'url': url},
    ).then((bool? value) => value ?? false);
  }


  @override
  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}