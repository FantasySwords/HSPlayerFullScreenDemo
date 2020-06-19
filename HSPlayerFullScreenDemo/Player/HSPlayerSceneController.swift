//
//  HSPlayerSceneController.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/8.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit

class HSPlayerSceneController: UIViewController {
    
    var interfaceOrientationMask:UIInterfaceOrientationMask? = nil
    var shouldNotAutorotate:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override var shouldAutorotate:Bool{
        return !self.shouldNotAutorotate
    }
    
    override var supportedInterfaceOrientations:UIInterfaceOrientationMask{
        if self.interfaceOrientationMask != nil {
            return self.interfaceOrientationMask!
        }
        return .landscape
    }
    
    var _statusBarHiden:Bool = false
    
    override var prefersStatusBarHidden: Bool{
        return self._statusBarHiden
    }
    
    var statusBarHiden:Bool{
        get{
            return _statusBarHiden
        }
        
        set{
            _statusBarHiden = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
}
