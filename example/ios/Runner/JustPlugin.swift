//
//  JustPlugin.swift
//  Runner
//
//  Created by littlegnal on 2020/12/16.
//

import Foundation

extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

public class JustPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "just_channel", binaryMessenger: registrar.messenger())
    let instance = JustPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "start_flutter_activity":
        if let topVC = UIApplication.getTopViewController() {
            let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
            let flutterViewController =
                FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
            flutterViewController.modalPresentationStyle = .overFullScreen
            topVC.present(flutterViewController, animated: true, completion: nil)
        }
        result(true)
    case "finish_activity":
        if let topVC = UIApplication.getTopViewController() {
            topVC.dismiss(animated: true, completion: nil)
        }
        result(true)
    default:
        result(FlutterMethodNotImplemented)
    }
    
  }
}
