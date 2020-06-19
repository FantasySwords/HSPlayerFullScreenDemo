//
//  ViewController.swift
//  HSPlayerFullScreenDemo
//
//  Created by hejianyuan on 2020/6/4.
//  Copyright © 2020 hejianyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView {
        let tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }

    var dataArray: NSArray = ["ViewController原生旋转",
                              "播放器View旋转",
                              "播放器View旋转+添加播放器竖屏Window",
                              "添加播放器横屏Window"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        /// 背景色
        view.backgroundColor = UIColor.white

        /// 导航栏
        navigationItem.title = "播放器全屏"

        /// subView
        view.addSubview(tableView)
        tableView.reloadData()
    }

    // UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
            cell?.textLabel?.textColor = UIColor.black
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none
            cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }

        cell?.textLabel?.text = dataArray[indexPath.row] as? String

        return cell!
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = HSNativeRotationViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = HSPlayerRotationViewController()
            navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = HSPlayerRotationViewWithWindowController()
            navigationController?.pushViewController(viewController, animated: true)
        case 3:
            let viewController = HSPlayerRotationViewWithLandscapeController()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            print("")
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
