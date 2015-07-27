//
//  NavController.swift
//  QQFrameWorkDemo
//
//  Created by 颜魏 on 15/7/23.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UISwipeGestureRecognizer(target: self, action: "actionSwip")
        
        gesture.direction = UISwipeGestureRecognizerDirection.Right
        
        self.view.addGestureRecognizer(gesture)
    
    }

    func actionSwip() {
        print("右滑了")

        self.popViewControllerAnimated(true)
    }

}
