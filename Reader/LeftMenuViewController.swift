//
//  LeftMenuViewController.swift
//  Reader
//
//  Created by mosquito on 2017/7/12.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {

    let headerViewH: CGFloat = 200
    fileprivate let cellIdentifier = "WLCellIdentifier"
    
    var dataArray = [["我的包月","sidebar_purse"],
                     ["我的消息","sidebar_decoration"],
                     ["浏览历史","sidebar_favorit"],
                     ["成为作家","sidebar_file"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(headerView)
        view.addSubview(tableView)
    }
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: self.headerViewH, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - self.headerViewH), style: .plain)
        tableView.backgroundColor = UIColor(colorLiteralRed: 13.0 / 255.0, green: 184.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        return tableView
    }()
    
    
    private lazy var headerView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.headerViewH))
        let bgImageView = UIImageView(frame: view.frame)
        bgImageView.image = UIImage(named: "sidebar_bg")
        bgImageView.contentMode = UIViewContentMode.scaleAspectFill
        bgImageView.clipsToBounds = true
        view.addSubview(bgImageView)
        return view
        
    }()
    
    //MARK: - TableViewDelegate&dataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = dataArray[indexPath.row][0]
        cell.imageView?.image = UIImage(named: dataArray[indexPath.row][1])
        cell.textLabel?.textColor = UIColor.white
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        vc.title = dataArray[indexPath.row][0]
        DrawerViewController.sharedDrawer?.LeftViewController(didSelectController: vc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
