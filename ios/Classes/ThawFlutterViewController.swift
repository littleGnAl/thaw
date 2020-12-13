// Copyright (c) 2020, Littlegnal
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
// 
// 3. Neither the name of the copyright holder nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
        // Borrow from  https://github.com/gfaraday/g_faraday/blob/4bb3036f78fab50cc986a1ae18402e3eab6e1242/ios/Classes/FaradayFlutterViewController.swift#L109
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
