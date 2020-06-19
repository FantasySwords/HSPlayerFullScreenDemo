//
//  HSPlayerView1.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/10.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import SnapKit
import UIKit

class HSPlayerView1: UIView {
    var imageView: UIImageView = UIImageView(image: UIImage(named: "movie.jpg"))
    var playerControlView: HSPlayerControlView = HSPlayerControlView()

    var playerBackAction: VoidFunc?
    var playerFullScreenAction: VoidFunc?

    var isFullScreen: Bool = false

    var playerContainerView: UIView?

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

    func replacePlayerContainerView(view: UIView) {
        if superview != nil {
            removeFromSuperview()
        }
        playerContainerView = view
        playerContainerView?.addSubview(self)

        snp.remakeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }

        playerControlView.playerControlBackAction = { () -> Void in
            if let action = self.playerBackAction {
                action()
            }
        }

        playerControlView.playerControlFullScreenAction = { () -> Void in
            if let action = self.playerFullScreenAction {
                action()
            }
        }
    }
}
