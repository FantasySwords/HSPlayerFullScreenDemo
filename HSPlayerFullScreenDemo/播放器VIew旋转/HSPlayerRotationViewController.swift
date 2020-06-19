//
//  HSPlayerRotationViewController.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/8.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit

class HSPlayerRotationViewController: UIViewController {
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

    var playerView: HSPlayerView2?

    var playerContainerView: UIView = UIView()

    func setupUI() {
        view.backgroundColor = UIColor.white

        view.addSubview(playerContainerView)
        playerContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIDevice.isIPhoneX() ? 44 : 20)
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: UIScreen.screenWidth(), height: UIScreen.screenWidth() / 16.0 * 9.0))
        }

        playerView = HSPlayerView2(playerContainerView: playerContainerView)
        playerView?.frame = CGRect(x: 0, y: 0, width: UIScreen.screenWidth(), height: UIScreen.screenWidth() / 16.0 * 9.0)

        
        playerView?.playerBackAction = { [weak self] () -> Void in
            if self?.playerView?.isFullScreen ?? false {
                self?.playerView?.exitFullScreen()
            } else {
                self?.navigationController?.popViewController(animated: true)
            }
        }

        playerView?.playerFullScreenAction = { [weak self] () -> Void in
            if self?.playerView?.isFullScreen ?? false {
                self?.playerView?.exitFullScreen()
            } else {
                self?.playerView?.enterFullScreen()
            }
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
