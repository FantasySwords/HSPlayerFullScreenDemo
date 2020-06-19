//
//  UIViewController+Transition.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/8.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit

extension UITabBarController{
    open override var shouldAutorotate: Bool{
        let selected = self.selectedViewController;
        if selected?.isKind(of: UITabBarController.classForCoder()) ?? false{
            let nav = selected as! UINavigationController
            return nav.topViewController!.shouldAutorotate
        }else{
            return selected!.shouldAutorotate
        }
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        let selected = self.selectedViewController;
        if selected?.isKind(of: UITabBarController.classForCoder()) ?? false{
            let nav = selected as! UINavigationController
            return nav.topViewController!.supportedInterfaceOrientations
        }else{
            return selected!.supportedInterfaceOrientations
        }
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        let selected = self.selectedViewController;
        if selected?.isKind(of: UITabBarController.classForCoder()) ?? false{
            let nav = selected as! UINavigationController
            return nav.topViewController!.preferredInterfaceOrientationForPresentation
        }else{
            return selected!.preferredInterfaceOrientationForPresentation
        }
    }
}

extension UINavigationController{
    open override var shouldAutorotate: Bool{
        return self.topViewController!.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return self.topViewController!.supportedInterfaceOrientations
    }
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return self.topViewController!.preferredInterfaceOrientationForPresentation
    }
    
    open override var childForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
    
    open override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
    
    open override var childForHomeIndicatorAutoHidden: UIViewController?{
        return self.topViewController
    }
}
