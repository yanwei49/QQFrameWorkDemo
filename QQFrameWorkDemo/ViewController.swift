//
//  ViewController.swift
//  QQFrameWorkDemo
//
//  Created by 颜魏 on 15/7/16.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let index = arc4random_uniform(255)
        let color = UIColor(red: CGFloat(index)/256.0, green: CGFloat(index)/256.0, blue: CGFloat(index)/256.0, alpha: 1)
        view.backgroundColor = color
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Done, target: self, action: "actionPush")

        let button = UIButton(frame: CGRectMake(10, 200, 100, 100))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "actionPush1", forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func actionPush1() {
        self.navigationController?.showViewController(ViewController(), sender: nil)
    }
    
    func actionPush() {
        SliderMenuViewController.sharedInstance.addAllGesture()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

