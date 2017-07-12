//
//  BookShelfViewController.swift
//  Reader
//
//  Created by mosquito on 2017/7/12.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

class BookShelfViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        DrawerViewController.sharedDrawer?.openLeftMenu()
    }
    
    
    @IBAction func showAlert(_ sender: Any) {
        let popVC = PopTableViewController()
        popVC.modalPresentationStyle = UIModalPresentationStyle.popover
        popVC.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        popVC.popoverPresentationController?.delegate = self
        popVC.popoverPresentationController?.backgroundColor = UIColor.white
        present(popVC, animated: true, completion: nil)
    }
    
    //MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}
