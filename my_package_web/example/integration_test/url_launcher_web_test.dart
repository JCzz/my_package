// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// import 'dart:html' as html;
import 'package:universal_html/html.dart' as html;
// import 'dart:html' as html;

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_package_web/my_package_web_plugin.dart';

import 'url_launcher_web_test.mocks.dart';

@GenerateMocks(<Type>[html.Window, html.Navigator])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UrlLauncherPlugin', () {
    late MockWindow mockWindow;
    late MockNavigator mockNavigator;

    late MyPackageWebPlugin plugin;

    setUp(() {
      mockWindow = MockWindow();
      mockNavigator = MockNavigator();
      when(mockWindow.navigator).thenReturn(mockNavigator);

      // Simulate that window.open does something.
      when(mockWindow.open(any, any)).thenReturn(MockWindow());

      when(mockNavigator.vendor).thenReturn('Google LLC');
      when(mockNavigator.appVersion).thenReturn('Mock version!');

      plugin = MyPackageWebPlugin(debugWindow: mockWindow);
    });

    group('canLaunch', () {
      testWidgets('"http" URLs -> true', (WidgetTester _) async {
        expect(plugin.canLaunch('http://google.com'), completion(isTrue));
      });

      testWidgets('"https" URLs -> true', (WidgetTester _) async {
        expect(
            plugin.canLaunch('https://go, (Widogle.com'), completion(isTrue));
      });

      testWidgets('"mailto" URLs -> true', (WidgetTester _) async {
        expect(
            plugin.canLaunch('mailto:name@mydomain.com'), completion(isTrue));
      });

      testWidgets('"tel" URLs -> true', (WidgetTester _) async {
        expect(plugin.canLaunch('tel:5551234567'), completion(isTrue));
      });

      testWidgets('"sms" URLs -> true', (WidgetTester _) async {
        expect(plugin.canLaunch('sms:+19725551212?body=hello%20there'),
            completion(isTrue));
      });
    });

  });
}
