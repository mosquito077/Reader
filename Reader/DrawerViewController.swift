//
//  DrawerViewController.swift
//  Reader
//
//  Created by mosquito on 2017/7/12.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {
    
    let screenW = UIScreen.main.bounds.width
    
    var mainVC: UIViewController?
    var leftVC: UIViewController?
    var maxWidth: CGFloat = 260
    
    //MARK: - 单例
    static let sharedDrawer = UIApplication.shared.keyWindow?.rootViewController as? DrawerViewController
    
    init(mainVC: UIViewController, leftMenuVC: UIViewController, leftWidth: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        
        self.mainVC = mainVC
        self.leftVC = leftMenuVC
        self.maxWidth = leftWidth
        
        view.addSubview(leftMenuVC.view)
        view.addSubview(mainVC.view)
        
        addChildViewController(leftMenuVC)
        addChildViewController(mainVC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        leftVC?.view.transform = CGAffineTransform(translationX: -maxWidth, y: 0)
        
        for childViewController in (mainVC?.childViewControllers)! {
            addScreenEdgePanGestureRecognizerToView(view: childViewController.view)
        }
    }
    
    //MARK: - 侧边栏跳转功能
    func LeftViewController(didSelectController view: UIViewController) {
        let tabbarVC = mainVC as? UITabBarController
        let nav = tabbarVC?.selectedViewController as? UINavigationController
        view.hidesBottomBarWhenPushed = true
        nav?.pushViewController(view, animated: false)
        closeLeftMenu()
    }
    
    //MARK: - 添加屏幕边缘手势
    private func addScreenEdgePanGestureRecognizerToView(view: UIView) {
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgPanGesture(_:)))
        pan.edges = UIRectEdge.left
        view.addGestureRecognizer(pan)
    }
    
    //MARK: - 屏幕左边缘手势
    func edgPanGesture(_ pan: UIScreenEdgePanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x
        
        if pan.state == UIGestureRecognizerState.changed && offsetX <= maxWidth {
            
            mainVC?.view.transform = CGAffineTransform(translationX: max(offsetX, 0), y: 0)
            leftVC?.view.transform = CGAffineTransform(translationX: -maxWidth + offsetX, y: 0)
            
        } else if pan.state == UIGestureRecognizerState.ended || pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed {
            
            if offsetX > screenW * 0.5 {
                openLeftMenu()
            } else {
                closeLeftMenu()
            }
        }
    }
    
    //MARK: - 遮盖按钮手势
    func panCloseLeftMenu(_ pan: UIPanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x
        if offsetX > 0 {
            return
        }
        
        if pan.state == UIGestureRecognizerState.changed && offsetX >= -maxWidth {
            
            let distace = maxWidth + offsetX

            mainVC?.view.transform = CGAffineTransform(translationX: distace, y: 0)
            leftVC?.view.transform = CGAffineTransform(translationX: offsetX, y: 0)
            
        } else if pan.state == UIGestureRecognizerState.ended || pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed {
            
            if offsetX > screenW * 0.5 {
                openLeftMenu()
            } else {
                closeLeftMenu()
            }
        }
    }
    
    //MARK: - 打开左侧菜单
    func openLeftMenu() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.mainVC?.view.addSubview(self.coverBtn)
            self.leftVC?.view.transform = CGAffineTransform.identity
            self.mainVC?.view.transform = CGAffineTransform(translationX: self.maxWidth, y: 0)
        }, completion: {
            (finish: Bool) -> () in
            
        })
    }
    
    //MARK: - 关闭左侧菜单
    func closeLeftMenu() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.leftVC?.view.transform = CGAffineTransform(translationX: -self.maxWidth, y: 0)
            self.mainVC?.view.transform = CGAffineTransform.identity
        }, completion: {
            (finish: Bool) -> () in
            self.coverBtn.removeFromSuperview()
        })
    }
    
    //MARK: - 灰色背景按钮
    private lazy var coverBtn: UIButton = {
        let btn = UIButton(frame: (self.mainVC?.view.bounds)!)
        btn.backgroundColor = UIColor(colorLiteralRed: 53.0 / 255.0, green: 53.0 / 255.0, blue: 53.0 / 255.0, alpha: 0.8)
        btn.addTarget(self, action: #selector(closeLeftMenu), for: .touchUpInside)
        btn.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCloseLeftMenu(_:))))
        return btn
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
