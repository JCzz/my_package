
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_package_platform_interface/my_package_platform_interface.dart';

const MethodChannel _channel = MethodChannel('plugins.mydomain.com/my_package_android');

class MyPackageAndroid extends MyPackagePlatform {

  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith() {
    MyPackagePlatform.instance = MyPackageAndroid();
  }

  @override
  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> canLaunch(String url) async {
    final bool canLaunchSpecificUrl = await _canLaunchUrl(url);
    if (!canLaunchSpecificUrl) {
      final String scheme = _getUrlScheme(url);

      if (scheme == 'http' || scheme == 'https') {
        return await _canLaunchUrl('$scheme://flutter.dev');
      }
    }
    return canLaunchSpecificUrl;
  }

  Future<bool> _canLaunchUrl(String url) {
    return _channel.invokeMethod<bool>(
      'canLaunch',
      <String, Object>{'url': url},
    ).then((bool? value) => value ?? false);
  }

  String _getUrlScheme(String url) {
    final int schemeEnd = url.indexOf(':');
    if (schemeEnd == -1) {
      return '';
    }
    return url.substring(0, schemeEnd);
  }

}
