import UIKit
import Flutter
import thaw

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    lazy var flutterEngine = FlutterEngine(name: "cache_engine")

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run();
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
        
        
        JustPlugin.register(with: self.flutterEngine.registrar(forPlugin: "JustPlugin") as! FlutterPluginRegistrar)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        // Create a view controller
        let viewController = ThawFlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        // Assign the view controller as `window`'s root view controller
        window?.rootViewController = viewController
        // Show the window
        window?.makeKeyAndVisible()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}
