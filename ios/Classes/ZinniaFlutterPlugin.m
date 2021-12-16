#import "ZinniaFlutterPlugin.h"
#if __has_include(<zinnia_flutter/zinnia_flutter-Swift.h>)
#import <zinnia_flutter/zinnia_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zinnia_flutter-Swift.h"
#endif

@implementation ZinniaFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZinniaFlutterPlugin registerWithRegistrar:registrar];
}
@end
