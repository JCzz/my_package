import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_package_ios/my_package_ios.dart';
import 'package:my_package_platform_interface/my_package_platform_interface.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _canLaunch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    bool canLaunch = false;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // platformVersion =
      //    await MyPackageIos.platformVersion ?? 'Unknown platform version';
      // final MyPackagePlatform launcher = MyPackagePlatform.instance;
      // canCall = await launcher.canLaunch("http://google.com");
      MyPackagePlatform.instance.canLaunch("http://google.com").then((value) => setState((){canLaunch = value;}));
      platformVersion = await MyPackagePlatform.instance.platformVersion ??
          'Unknown platform version';
    // getPlatformVersion.then((value) => print(value));
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _canLaunch = canLaunch;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MyPackagePlatform.instance.canLaunch("http://google.com").then((value) => print(value));
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Running on: $_platformVersion\n'),
                  Text('CanLaunch on: $_canLaunch\n'),
                ])),
      ),
    );
  }
}
