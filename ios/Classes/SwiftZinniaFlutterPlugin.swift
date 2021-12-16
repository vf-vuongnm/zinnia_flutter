import Flutter
import UIKit

public class SwiftZinniaFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zinnia_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftZinniaFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
  }
}
