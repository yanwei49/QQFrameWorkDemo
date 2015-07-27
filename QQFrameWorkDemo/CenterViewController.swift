
//
//  CenterViewController.swift
//  QQFrameWorkDemo
//
//  Created by 颜魏 on 15/7/16.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {

    var tabBar: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        createNav()
        createTabBar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        SliderMenuViewController.sharedInstance.addAllGesture()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        SliderMenuViewController.sharedInstance.removeAllGesture()
    }
    
    //创建导航栏
    func createNav() {
        let leftItem = UIBarButtonItem(title: "左侧", style: UIBarButtonItemStyle.Plain, target: self, action: "actionShowLeftViewController")
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(title: "右侧", style: UIBarButtonItemStyle.Plain, target: self, action: "actionShowRightViewController")
        self.navigationItem.rightBarButtonItem = rightItem
    }

    //创建TabBar
    func createTabBar() {
        tabBar = UITabBarController()
        tabBar.view.frame = view.bounds
        tabBar.view.backgroundColor = UIColor.clearColor()
        let messageVC = MessageViewController()
        messageVC.tabBarItem.title = "消息"
        let friendsVC = FriendsViewContorller()
        friendsVC.tabBarItem.title = "好友"
        let dynamicVC = DynamicViewController()
        dynamicVC.tabBarItem.title = "动态"
        tabBar.viewControllers = [messageVC, friendsVC, dynamicVC]
        tabBar.selectedIndex = 0
        view.addSubview(tabBar.view)
    }
    
    func actionShowLeftViewController() {
        SliderMenuViewController.sharedInstance.actionShowLeftViewController()
    }
    
    func actionShowRightViewController() {
        SliderMenuViewController.sharedInstance.actionShowRightViewController()
    }

}
