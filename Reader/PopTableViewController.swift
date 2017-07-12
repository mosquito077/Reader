//
//  PopTableViewController.swift
//  Reader
//
//  Created by mosquito on 2017/7/12.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit

class PopTableViewController: UITableViewController {

    var dataArray = ["导入书籍", "列表模式", "书架分组", "编辑书架"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        preferredContentSize = CGSize(width: 150, height: 145)
        tableView.rowHeight = 35

    }
    
    //MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
