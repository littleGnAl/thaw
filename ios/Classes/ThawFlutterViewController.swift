//
//  ThawFlutterViewController.swift
//  thaw
//
//  Created by littlegnal on 2020/12/19.
//

import Foundation

open class ThawFlutterViewController: FlutterViewController {
    
    private var isShowing = false
    
    private weak var previousFlutterViewController: ThawFlutterViewController?
    
    public override init(engine: FlutterEngine, nibName: String?, bundle nibBundle: Bundle?) {
        previousFlutterViewController = engine.viewController as? ThawFlutterViewController
        isShowing = true
        
        super.init(engine: engine, nibName: nibName, bundle: nibBundle)
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        engine?.viewController = self
        isShowing = true
        
        super.viewWillAppear(animated)
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        if let p = previousFlutterViewController, p.isShowing {
            p.viewWillAppear(false)
            p.viewDidLayoutSubviews()
            p.viewDidAppear(false)
        }
        super.viewWillDisappear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        isShowing = false
        super.viewDidDisappear(animated)
    }
}
