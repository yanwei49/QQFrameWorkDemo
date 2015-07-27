
//
//  LeftViewController.swift
//  QQFrameWorkDemo
//
//  Created by 颜魏 on 15/7/16.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.greenColor()
        
        tableView = UITableView(frame: CGRectMake(20, 100, 150, 300), style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = "你好啊"
        cell?.inputAccessoryView?.hidden = false
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nav = SliderMenuViewController.sharedInstance.centerVC as! UINavigationController
        nav.pushViewController(ViewController(), animated: false)
        SliderMenuViewController.sharedInstance.showCenterView(0.5)
    }
    
    func actionPush() {
        let nav = SliderMenuViewController.sharedInstance.centerVC as! UINavigationController
        nav.pushViewController(ViewController(), animated: false)
        SliderMenuViewController.sharedInstance.showCenterView(0.5)
    }

}
