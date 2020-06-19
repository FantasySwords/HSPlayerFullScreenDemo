//
//  HSPlayerControlView.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/4.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit


typealias VoidFunc = ()->Void

class HSPlayerControlView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        self.setupUI()
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.clear
        
        let backButton = UIButton.init(type: UIButton.ButtonType.custom)
        backButton.backgroundColor = UIColor.red
        backButton.setTitle("返回", for: UIControl.State.normal)
        backButton.titleLabel?.textColor = UIColor.white
        backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        self.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
        
        let fullScreenButton = UIButton.init(type: UIButton.ButtonType.custom)
        fullScreenButton.backgroundColor = UIColor.red
        fullScreenButton.setTitle("全屏", for: UIControl.State.normal)
        fullScreenButton.titleLabel?.textColor = UIColor.white
        fullScreenButton.addTarget(self, action: #selector(fullScreenButtonAction), for: UIControl.Event.touchUpInside)
        self.addSubview(fullScreenButton)
        
        fullScreenButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 80, height: 40))
        }
    }
    
    var playerControlBackAction:VoidFunc?
    var playerControlFullScreenAction:VoidFunc?
    
    
    @objc func backButtonAction(){
        if self.playerControlBackAction != nil {
            playerControlBackAction?()
        }
    }
    
    @objc func fullScreenButtonAction(){
        if self.playerControlFullScreenAction != nil {
            playerControlFullScreenAction?()
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var next = true
        for  view in self.subviews {
            if view is UIControl {
                if view.frame.contains(point) {
                    next = false
                    break
                }
            }
        }
        return !next
    }
    
}
