//
//  SliderMenuViewController.swift
//  QQFrameWorkDemo
//
//  Created by 颜魏 on 15/7/16.
//  Copyright © 2015年 颜魏. All rights reserved.
//

import UIKit


class SliderMenuViewController: UIViewController {

    var isShowCenterView: Bool = true
    
    var leftView: UIView!
    var rightView: UIView!
    var centerView: UIView!
    var tap: UITapGestureRecognizer!
    var pan: UIPanGestureRecognizer!
    
    let width = UIScreen.mainScreen().bounds.width
    let height = UIScreen.mainScreen().bounds.height
    
    static var sliderMenu: SliderMenuViewController?
    static var once: dispatch_once_t = 0

    class var sharedInstance: SliderMenuViewController {
        dispatch_once(&once) { () -> Void in
            sliderMenu = SliderMenuViewController()
        }
        
        return sliderMenu!
    }
    
    var leftVC: UIViewController? {
        didSet {
            leftView = UIView(frame: view.bounds)
            self.addChildViewController(leftVC!)
            leftView.addSubview(leftVC!.view)
            view.addSubview(leftView)
            if centerView != nil {
                view.bringSubviewToFront(centerView)
            }
        }
    }
    var centerVC: UIViewController? {
        didSet {
            centerView = UIView(frame: view.bounds)
            self.addChildViewController(centerVC!)
            centerView.addSubview(centerVC!.view)
            view.addSubview(centerView)
            tap = UITapGestureRecognizer(target: self, action: "tap:")
            pan = UIPanGestureRecognizer(target: self, action: "pan:")
            centerView.addGestureRecognizer(tap)
            centerView.addGestureRecognizer(pan)
        }
    }
    var rightVC: UIViewController? {
        didSet {
            rightView = UIView(frame: view.bounds)
            self.addChildViewController(rightVC!)
            rightView.addSubview(rightVC!.view)
            view.addSubview(rightView)
            if centerView != nil {
                view.bringSubviewToFront(centerView)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func addAllGesture() {
        centerView.addGestureRecognizer(tap)
        centerView.addGestureRecognizer(pan)
    }
    
    func removeAllGesture() {
        centerView.removeGestureRecognizer(tap)
        centerView.removeGestureRecognizer(pan)
    }
    
    //左导航按钮，自动检测是隐藏还是显示左侧视图
    func actionShowLeftViewController() {
        if leftVC != nil {
            if isShowCenterView == true {
                isShowCenterView = false
                showLeftView(0.5)
            }else {
                isShowCenterView = true
                showCenterView(0.5)
            }
        }
    }
    
    //右导航按钮事件，自动检测是隐藏还是显示右侧视图
    func actionShowRightViewController() {
        if rightVC != nil {
            if isShowCenterView == true {
                isShowCenterView = false
                showRightView(0.5)
            }else {
                isShowCenterView = true
                showCenterView(0.5)
            }
        }
    }
    
    //显示左侧视图
    private func showLeftView(duration: NSTimeInterval) {
        if rightView != nil {
            view.sendSubviewToBack(rightView)
        }
        distance = self.view.center.x * (fullDistance*2 + Proportion - 1)
        UIView.animateWithDuration(duration) { () -> Void in
            self.centerView.center = CGPointMake(UIScreen.mainScreen().bounds.width+80, self.view.center.y)
            self.centerView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        }
    }
    
    //显示中间视图
    func showCenterView(duration: NSTimeInterval) {
        isShowCenterView = true
        distance = 0
        UIView.animateWithDuration(duration) { () -> Void in
            self.centerView.center = CGPointMake(self.width/2, self.height/2)
            self.centerView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
    }
    
    //显示右侧视图
    private func showRightView(duration: NSTimeInterval) {
        if leftView != nil {
            view.sendSubviewToBack(leftView)
        }
        distance = self.view.center.x * -(fullDistance*2 + Proportion - 1)
        UIView.animateWithDuration(duration) { () -> Void in
            self.centerView.center = CGPointMake(-80, self.view.center.y)
            self.centerView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        }
    }
 
    //敲击手势响应事件
    func tap(gesture: UITapGestureRecognizer) {
        if isShowCenterView != true {
            isShowCenterView = true
            showCenterView(0.5)
        }
    }
    
    let fullDistance: CGFloat = 0.8
    let Proportion: CGFloat = 0.8
    var distance: CGFloat = 0

    //拖拽手势响应事件
    func pan(gesture: UIPanGestureRecognizer) {
        let x = gesture.translationInView(view).x    // 实时距离
        let trueDistance = distance + x // 实时距离
        if trueDistance > 0 {
            if leftView == nil {
                return
            }else if rightView != nil {
                view.sendSubviewToBack(rightView)
            }
        }else if trueDistance < 0 {
            if rightView == nil {
                return
            }else if leftView != nil {
                view.sendSubviewToBack(leftView)
            }
        }
        
        var proportion: CGFloat = gesture.view!.frame.origin.x >= 0 ? -1 : 1
        // 计算缩放比例
        proportion *= trueDistance / width
        proportion *= 1 - Proportion
        proportion /= fullDistance + Proportion/2 - 0.5
        proportion += 1
        if proportion <= Proportion { // 若比例已经达到最小，则不再继续动画
            return
        }
        
        // 如果 UIPanGestureRecognizer 结束，则激活自动停靠
        if gesture.state == UIGestureRecognizerState.Ended {
            if trueDistance < 120 && trueDistance > -120 {
                isShowCenterView = true
                showCenterView(NSTimeInterval(0.5-0.5*abs(x)/(width-80)))
            }else if trueDistance >= 120 {
                isShowCenterView = false
                showLeftView(NSTimeInterval(0.5-0.5*abs(x)/(width-80)))
            }else {
                isShowCenterView = false
                showRightView(NSTimeInterval(0.5-0.5*abs(x)/(width-80)))
            }
            
            return
        }
        
        // 执行平移和缩放动画
        centerView.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y)
        centerView.transform = CGAffineTransformMakeScale(proportion, proportion)
        
    }

}
