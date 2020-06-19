//
//  HSPlayerView.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/4.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import SnapKit
import UIKit

class HSPlayerView2: UIView {
    var imageView: UIImageView = UIImageView(image: UIImage(named: "movie.jpg"))
    var playerControlView: HSPlayerControlView = HSPlayerControlView()

    var playerBackAction: VoidFunc?
    var playerFullScreenAction: VoidFunc?

    var isFullScreen: Bool = false
    var isTransitioning:Bool = false
    
    weak var playerContainerView: UIView?
    var playerTransitionView = UIView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        setupUI()
    }

    init(playerContainerView: UIView) {
        super.init(frame: CGRect())
        setupUI()
        replacePlayerContainerView(view: playerContainerView)
        setupDeviceOrientationObserver()
    }
    
    deinit {
        self.playerTransitionView.removeFromSuperview()
        self.removeFromSuperview()
        self.playerContainerView = nil
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }

    func setupUI() {
        backgroundColor = UIColor.black
        addSubview(imageView)
        addSubview(playerControlView)

        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true

        imageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        playerControlView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupDeviceOrientationObserver(){
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(onDeviceOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func onDeviceOrientationChange(){
        let currentDeviceOrientation = UIDevice.current.orientation
        guard currentDeviceOrientation.isPortrait || currentDeviceOrientation.isLandscape else {
            return
        }
        
        switch currentDeviceOrientation {
        case UIDeviceOrientation.portrait:
            transitionTo(orientation: .portrait, animated: true)
        case UIDeviceOrientation.landscapeLeft:
            transitionTo(orientation: .landscapeRight, animated: true)
        case UIDeviceOrientation.landscapeRight:
            transitionTo(orientation: .landscapeLeft, animated: true)

        default:
            break
        }
        
    }
    

    func replacePlayerContainerView(view: UIView) {
        if superview != nil {
            removeFromSuperview()
        }
        playerContainerView = view
        playerContainerView?.addSubview(self)
        frame = playerControlView.bounds

        playerControlView.playerControlBackAction = {[weak self] () -> Void in
            if let action = self?.playerBackAction {
                action()
            }
        }

        playerControlView.playerControlFullScreenAction = {[weak self] () -> Void in
            if let action = self?.playerFullScreenAction {
                action()
            }
        }
    }
}

extension HSPlayerView2 {
    func transitionTo(orientation: UIInterfaceOrientation, animated: Bool) {
        if orientation.isLandscape {
            transitionToLandscape(orientation: orientation, animated: animated)
        } else if orientation.isPortrait {
            transitionToPortrait(animated: animated)
        }
    }

    func transitionToLandscape(orientation: UIInterfaceOrientation, animated: Bool) {
        guard orientation.isLandscape && !isTransitioning else {
            return
        }
        
        isFullScreen = true
        isTransitioning = true
        
        let currentOrientation = UIApplication.shared.statusBarOrientation
        let keyWindow: UIWindow? = (UIApplication.shared.delegate?.window)!
        let containerFrame = playerContainerView?.convert(playerContainerView!.bounds, to: playerContainerView?.window)

        let maxValue: CGFloat = max(UIScreen.screenHeight(), UIScreen.screenWidth())
        let minValue: CGFloat = min(UIScreen.screenHeight(), UIScreen.screenWidth())

        let toBounds = CGRect(x: 0, y: 0, width: maxValue, height: minValue)
        let toCenter = keyWindow!.center

        if currentOrientation.isPortrait {
            playerTransitionView.frame = containerFrame!
            frame = playerTransitionView.bounds
            keyWindow?.addSubview(playerTransitionView)
            playerTransitionView.addSubview(self)
        }
        
        updateStatusBarAppearance()
        let sceneVC = HSPlayerSceneController()
        sceneVC.interfaceOrientationMask = (orientation == UIInterfaceOrientation.landscapeLeft) ? UIInterfaceOrientationMask.landscapeLeft : UIInterfaceOrientationMask.landscapeRight
        let sceneWnd = UIWindow(frame: UIScreen.main.bounds)
        sceneWnd.rootViewController = sceneVC

        let duration:TimeInterval = animated ?(currentOrientation.isPortrait ?0.35 :0.5) :0.0
        UIView.animateKeyframes(withDuration:duration, delay: 0, options: UIView.KeyframeAnimationOptions.layoutSubviews, animations: {
            self.playerTransitionView.transform = self.transformForRotation(orientation: orientation)
            self.playerTransitionView.center = toCenter
            self.playerTransitionView.bounds = toBounds
            self.frame = self.playerTransitionView.bounds
        }) { _ in
            self.isTransitioning = false
        }
    }

    func transitionToPortrait(animated: Bool) {
        let currentOrientation = UIApplication.shared.statusBarOrientation
        guard (currentOrientation != UIInterfaceOrientation.portrait) && !isTransitioning else {
            return
        }
      
        isTransitioning = true
        
        let toFrame = playerContainerView?.convert(playerContainerView!.bounds, to: playerContainerView?.window)

        updateStatusBarAppearance()
        let sceneVC = HSPlayerSceneController()
        sceneVC.interfaceOrientationMask = UIInterfaceOrientationMask.portrait
        let sceneWnd = UIWindow(frame: UIScreen.main.bounds)
        sceneWnd.rootViewController = sceneVC

        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: UIView.KeyframeAnimationOptions.layoutSubviews, animations: {
            self.playerTransitionView.transform = CGAffineTransform.identity
            self.playerTransitionView.frame = toFrame!
            self.frame = self.playerTransitionView.bounds
        }) { _ in
            self.replacePlayerContainerView(view: self.playerContainerView!)
            self.isFullScreen = false
            self.playerTransitionView.removeFromSuperview()
            self.isTransitioning = false
        }
    }

    func transformForRotation(orientation: UIInterfaceOrientation) -> CGAffineTransform {
        switch orientation {
        case UIInterfaceOrientation.portrait:
            return CGAffineTransform.identity
        case UIInterfaceOrientation.landscapeLeft:
            return CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
        case UIInterfaceOrientation.landscapeRight:
            return CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        default:
            return CGAffineTransform.identity
        }
    }

    func updateStatusBarAppearance() {
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        var top: UIViewController? = window?.rootViewController

        while true {
            if top?.presentingViewController != nil {
                top = top?.presentingViewController
            } else if top is UINavigationController {
                if let nav: UINavigationController = top as? UINavigationController {
                    top = nav.topViewController
                } else {
                    break
                }
            } else if top is UITabBarController {
                if let tab: UITabBarController = top as? UITabBarController {
                    top = tab.selectedViewController
                } else {
                    break
                }
            } else {
                break
            }
        }

        top?.setNeedsStatusBarAppearanceUpdate()
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    func enterFullScreen(_ animated: Bool = true){
        let orientation = UIDevice.current.orientation
        switch orientation {
        case UIDeviceOrientation.landscapeRight:
            transitionTo(orientation: .landscapeLeft, animated: animated)
        default:
            transitionTo(orientation: .landscapeRight, animated: animated)
            break
        }
    }
    
    func exitFullScreen(_ animated: Bool = true){
        transitionTo(orientation: .portrait, animated: animated)
    }
    
}
