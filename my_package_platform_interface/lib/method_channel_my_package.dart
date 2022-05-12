import 'dart:async';

import 'package:flutter/services.dart';

import 'link.dart';
import 'my_package_platform_interface.dart';

const MethodChannel _channel = MethodChannel('plugins.mydomain.com/my_package');

/// An implementation of [UrlLauncherPlatform] that uses method channels.
class MethodChannelMyPackage extends MyPackagePlatform {

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