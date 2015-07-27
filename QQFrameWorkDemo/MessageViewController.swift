

//
//  MessageViewController.swift
//  QQFrameWorkDemo
//
//  Created by 颜魏 on 15/7/16.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        let button = UIButton(frame: CGRectMake(10, 200, 100, 100))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "actionPush", forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func actionPush() {
        SliderMenuViewController.sharedInstance.centerVC?.showViewController(ViewController(), sender: nil)
    }
    

}
