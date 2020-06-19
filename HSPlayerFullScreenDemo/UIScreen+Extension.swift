//
//  UIScreen+Extension.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/4.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit

extension UIScreen{
    public class func screenWidth()->CGFloat{
        return UIScreen.main.bounds.width
    }
    
    public class func screenHeight()->CGFloat{
        return UIScreen.main.bounds.height
    }
}

extension UIDevice{
    public class func isIPhoneX()->Bool{
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.delegate?.window
            let safeInset = window??.safeAreaInsets.bottom;
            if safeInset! > CGFloat(0) {
                return true
            }
            return false
        } else {
            return false
        }
    }
}
