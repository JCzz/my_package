import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html show window;
// import 'dart:html' as html;
import 'package:universal_html/html.dart' as html;

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:my_package_platform_interface/my_package_platform_interface.dart';
import 'package:my_package_web/src/link.dart';

import 'src/shims/dart_ui.dart' as ui;
import 'src/third_party/platform_detect/browser.dart';

const Set<String> _safariTargetTopSchemes = <String>{
  'mailto',
  'tel',
  'sms',
};
String? _getUrlScheme(String url) => Uri.tryParse(url)?.scheme;

bool _isSafariTargetTopScheme(String url) =>
    _safariTargetTopSchemes.contains(_getUrlScheme(url));

/// A web implementation of the MyPackageWeb plugin.
class MyPackageWebPlugin extends MyPackagePlatform { // awear

  MyPackageWebPlugin({@visibleForTesting html.Window? debugWindow})
      : _window = debugWindow ?? html.window {
    _isSafari = navigatorIsSafari(_window.navigator);
  }

  final html.Window _window;
  bool _isSafari = false;

  // The set of schemes that can be handled by the plugin
  static final Set<String> _supportedSchemes = <String>{
    'http',
    'https',
  }.union(_safariTargetTopSchemes);

  /// Registers this class as the default instance of [UrlLauncherPlatform].
  static void registerWith(Registrar registrar) {
    MyPackagePlatform.instance = MyPackageWebPlugin();
    ui.platformViewRegistry
        .registerViewFactory(linkViewType, linkViewFactory, isVisible: false);
  }

  @override
  Future<bool> canLaunch(String url) {
    return Future<bool>.value(_supportedSchemes.contains(_getUrlScheme(url)));
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> get platformVersion async {
      final version = html.window.navigator.userAgent;
      return Future.value(version);
    }
}
