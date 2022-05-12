#import "MyPackageIosPlugin.h"
#if __has_include(<my_package_ios/my_package_ios-Swift.h>)
#import <my_package_ios/my_package_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "my_package_ios-Swift.h"
#endif

@implementation MyPackageIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyPackageIosPlugin registerWithRegistrar:registrar];
}
@end
