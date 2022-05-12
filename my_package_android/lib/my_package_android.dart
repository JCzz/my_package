
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_package_platform_interface/my_package_platform_interface.dart';

// const MethodChannel _channel =
// MethodChannel('plugins.flutter.io/url_launcher_android');

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
      // canLaunch can return false when a custom application is registered to
      // handle a web URL, but the caller doesn't have permission to see what
      // that handler is. If that happens, try a web URL (with the same scheme
      // variant, to be safe) that should not have a custom handler. If that
      // returns true, then there is a browser, which means that there is
      // at least one handler for the original URL.
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
