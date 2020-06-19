//
//  AppDelegate.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/4.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootController = ViewController.init()
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: rootController)
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.allButUpsideDown
    }
}
