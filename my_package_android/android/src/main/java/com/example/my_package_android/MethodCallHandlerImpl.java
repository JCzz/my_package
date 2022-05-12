// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package com.example.my_package_android;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.Nullable;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
// import io.flutter.plugins.urllauncher.UrlLauncher.LaunchStatus;
import android.content.ComponentName;

/**
 * Translates incoming UrlLauncher MethodCalls into well formed Java function calls for {@link
 * UrlLauncher}.
 */
final class MethodCallHandlerImpl implements MethodCallHandler {
  private static final String TAG = "MethodCallHandlerImpl";
  // private final UrlLauncher urlLauncher;
  @Nullable private MethodChannel channel;

  private final Context _applicationContext;

  /** Forwards all incoming MethodChannel calls to the given {@code urlLauncher}. */
  MethodCallHandlerImpl(Context applicationContext) { // UrlLauncher urlLauncher) {
    // this.urlLauncher = urlLauncher;
    _applicationContext = applicationContext;
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    final String url = call.argument("url");
    switch (call.method) {
      case "canLaunch":
        onCanLaunch(result, url);
        break;
      case "getPlatformVersion":
        onGetPlatformVersion(result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  /**
   * Registers this instance as a method call handler on the given {@code messenger}.
   *
   * <p>Stops any previously started and unstopped calls.
   *
   * <p>This should be cleaned with {@link #stopListening} once the messenger is disposed of.
   */
  void startListening(BinaryMessenger messenger) {
    if (channel != null) {
      Log.wtf(TAG, "Setting a method call handler before the last was disposed.");
      stopListening();
    }

    channel = new MethodChannel(messenger, "plugins.mydomain.com/my_package_android");
    channel.setMethodCallHandler(this);
  }

  /**
   * Clears this instance from listening to method calls.
   *
   * <p>Does nothing if {@link #startListening} hasn't been called, or if we're already stopped.
   */
  void stopListening() {
    if (channel == null) {
      Log.d(TAG, "Tried to stop listening when no MethodChannel had been initialized.");
      return;
    }

    channel.setMethodCallHandler(null);
    channel = null;
  }

  private void onCanLaunch(Result result, String url) {
    boolean _canLaunch = false;

    Intent launchIntent = new Intent(Intent.ACTION_VIEW);
    launchIntent.setData(Uri.parse(url));
    ComponentName componentName =
            launchIntent.resolveActivity(_applicationContext.getPackageManager());

    if (componentName == null) {
      Log.i(TAG, "component name for " + url + " is null");
      _canLaunch = false;
    } else {
      Log.i(TAG, "component name for " + url + " is " + componentName.toShortString());
      _canLaunch = !"{com.android.fallback/com.android.fallback.Fallback}"
              .equals(componentName.toShortString());
    }

    result.success(_canLaunch);
  }

  private void onGetPlatformVersion(Result result) {
    result.success("Android" + android.os.Build.VERSION.RELEASE);
  }

}
