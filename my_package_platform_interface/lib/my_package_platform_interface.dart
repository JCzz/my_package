import 'dart:async';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'method_channel_my_package.dart';

abstract class MyPackagePlatform extends PlatformInterface {
  MyPackagePlatform() : super(token: _token);

  static MyPackagePlatform _instance = MethodChannelMyPackage();

  static final Object _token = Object();

  static MyPackagePlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [UrlLauncherPlatform] when they register themselves.
  static set instance(MyPackagePlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  // Custom Interfaces

  /// Returns `true` if this platform is able to launch [url].
  Future<bool> canLaunch(String url) async {
    throw UnimplementedError('canLaunch() has not been implemented.');
  }

  /// Returns a [String] containing the version of the platform.
  Future<String?> get platformVersion async {
    throw UnimplementedError('getPlatformVersion property has not been implemented.');
  }

}
