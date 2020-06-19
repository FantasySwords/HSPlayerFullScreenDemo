//
//  HSNativeRotationViewController.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/4.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit

class HSNativeRotationViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    var playerView: HSPlayerView1?

    var playerContainerView: UIView = UIView()

    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(playerContainerView)
        playerContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIDevice.isIPhoneX() ? 44 : 20)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: UIScreen.screenWidth(), height: UIScreen.screenWidth() / 16.0 * 9.0))
        }

        playerView = HSPlayerView1(playerContainerView: playerContainerView)
        playerView?.frame = CGRect(x: 0, y: 0, width: UIScreen.screenWidth(), height: UIScreen.screenWidth() / 16.0 * 9.0)

        playerView?.playerBackAction = { () -> Void in
            let orientation = UIDevice.current.orientation
            if orientation.isLandscape {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                self.setNeedsStatusBarAppearanceUpdate()
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }

        playerView?.playerFullScreenAction = { () -> Void in
            let orientation = UIDevice.current.orientation
            if orientation.isLandscape {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            } else {
                let orientationRawValue = UIInterfaceOrientation.landscapeRight.rawValue
                UIDevice.current.setValue(orientationRawValue, forKey: "orientation")
            }

            self.setNeedsStatusBarAppearanceUpdate()
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let orientation = UIDevice.current.orientation
        let maxValue = max(UIScreen.screenHeight(), UIScreen.screenWidth())
        let minValue = min(UIScreen.screenHeight(), UIScreen.screenWidth())
        let width = orientation.isLandscape ?maxValue :minValue

        UIView.animate(withDuration: coordinator.transitionDuration, animations: {
            self.playerContainerView.snp.remakeConstraints { make in
                make.top.equalToSuperview().offset(orientation.isLandscape ? 0 : (UIDevice.isIPhoneX() ? 44 : 20))
                make.left.equalToSuperview()
                make.size.equalTo(CGSize(width: width, height: width / 16.0 * 9.0))
            }
            self.view.setNeedsLayout()
        }) { _ in
        }
    }
    
    
}
