import Flutter
import UIKit

public class SwiftMyPackageIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // let channel = FlutterMethodChannel(name: "my_package_ios", binaryMessenger: registrar.messenger())
    // let instance = SwiftMyPackageIosPlugin()
    // registrar.addMethodCallDelegate(instance, channel: channel)

        let channel = FlutterMethodChannel(name: "plugins.mydomain.com/my_package_ios", binaryMessenger: registrar.messenger())
        let instance = SwiftMyPackageIosPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case "canLaunch":
          result(true)
          break
      case "getPlatformVersion":
          result("iOS " + UIDevice.current.systemVersion)
          break
      default:
          print("Not found")
      }
      
      // result("iOS " + UIDevice.current.systemVersion)
  }
}
