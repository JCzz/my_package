import 'dart:async';

import 'package:my_package_platform_interface/my_package_platform_interface.dart';

Future<bool> canLaunchUrl(Uri url) async {
  return await MyPackagePlatform.instance.canLaunch(url.toString());
}

Future<String?> getPlatform() async {
  return await MyPackagePlatform.instance.platformVersion;
}