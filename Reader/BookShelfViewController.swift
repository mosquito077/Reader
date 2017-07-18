//
//  BookShelfViewController.swift
//  Reader
//
//  Created by mosquito on 2017/7/12.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit
import SnapKit

class BookShelfViewController: UIViewController, UIPopoverPresentationControllerDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NavViewProtocol, ReaderViewControllerDelegate {
    
    let backgroundHeight: CGFloat = 200
    let navViewHeight: CGFloat = 64
    
    var backgroundImage: UIImageView!
    var headImageView: UIImageView!
    var mainCollectionView: UICollectionView!
    var navView: NavView!
    
    var backImageHeight: CGFloat = 200
    
    var txtArray = [["一六二九", "1629"],
                    ["黑暗剑士", "black"],
                    ["三国无双", "three"],
                    ["数字人生", "number"],
                    ["异闻录", "novel"]]
    
    var pdfArray = [["iOS", "1704"],
                    ["Android", "17043"]]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initViews()
    }
    
    func initViews() {
        
        let image = UIImage(named: "background")
        backgroundImage = UIImageView(frame: CGRect.zero)
        backgroundImage.image = image
        backgroundImage.isUserInteractionEnabled = true
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(backgroundHeight)
        }
        
        navView = NavView.init(frame: CGRect(x: 0, y: 0, width: screenW, height: navViewHeight))
        navView.navViewDelegate = self
        navView.backgroundColor = UIColor.clear
        self.view.addSubview(navView)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (screenW-60)/3, height: 157.0)
        layout.sectionInset = UIEdgeInsets.zero
        mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        mainCollectionView.backgroundColor = UIColor.clear
        mainCollectionView.isScrollEnabled = true
        mainCollectionView.alwaysBounceVertical = true
        mainCollectionView.contentSize = CGSize(width: screenW, height: screenH)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        //注册一个cell
        mainCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        //注册headview
        mainCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        self.view.addSubview(mainCollectionView)
        
        mainCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(64)
            make.bottom.equalToSuperview().offset(-64.0)
        }
        
    }
    
    //MARK - collectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return txtArray.count
        } else if section == 2 {
            return pdfArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        
        if indexPath.section == 1 {
            cell.imageView?.image = UIImage(named: txtArray[indexPath.row][1])
            cell.nameLabel?.text = txtArray[indexPath.row][0]
        } else if indexPath.section == 2 {
            cell.imageView?.image = UIImage(named: pdfArray[indexPath.row][1])
            cell.nameLabel?.text = pdfArray[indexPath.row][0]
        }
        
        return cell
        
    }
    
    //返回HeaderView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if section == 0 {
            return CGSize(width: screenW, height: 136.0)
        } else {
           return CGSize(width: screenW, height: 45.0)
        }
    }
    
    //返回自定义的HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", for: indexPath as IndexPath)
        headView.backgroundColor = UIColor.clear
        
        let textArray = ["TXT小说", "PDF文档"]
        if indexPath.section == 1 || indexPath.section == 2 {
            let textLabel = UILabel(frame: CGRect(x: 15, y: 0, width: screenW, height: 45.0))
            textLabel.text = textArray[indexPath.section-1]
            textLabel.textColor = UIColor.colorWithHexString(hex: "BBBBBB")
            headView.backgroundColor = UIColor.colorWithHexString(hex: "F0F0F0")
            headView.addSubview(textLabel)
        }
        
        return headView

    }

    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if section == 0 {
            return UIEdgeInsets.zero
        }
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    //点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {             //txt小说
            let pageView: LSYReadPageViewController = LSYReadPageViewController.init()
            let fileURL = Bundle.main.url(forResource: txtArray[indexPath.row][0], withExtension: ".txt")
            pageView.resourceURL = fileURL
            pageView.model = LSYReadModel.getLocalModel(with: fileURL) as! LSYReadModel
            self.present(pageView, animated: true, completion: nil)
            
        } else if indexPath.section == 2 {     //pdf文档
            let fileUrl = Bundle.main.url(forResource: pdfArray[indexPath.row][0], withExtension: ".pdf")
            let fileString = fileUrl?.absoluteString
            let index = fileString?.index((fileString?.startIndex)!, offsetBy: 7)
            let filePath = fileString?.substring(from: index!)
            let document = ReaderDocument.withDocumentFilePath(filePath, password: nil)
            if (document != nil) {
                let readVC = ReaderViewController.init(readerDocument: document)
                readVC?.delegate = self
                readVC?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                readVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                self.present(readVC!, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - ReaderViewControllerDelegate
    func dismiss(_ viewController: ReaderViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - NavViewProtocol
    func navLeftButtonClick() {
        DrawerViewController.sharedDrawer?.openLeftMenu()
    }
    
    func navRightButtonClick(sender: UIButton) {
        let popoverView = PopoverView.init()
        popoverView.showShade = true
        popoverView.show(to: sender, with: bookAction())
    }
    
    func bookAction() -> Array<PopoverAction>{
        let importBookAction = PopoverAction.init(image: UIImage(named: "right_face")
            , title: "导入书籍", handler: nil)
        let listModeAction = PopoverAction.init(image:  UIImage(named: "right_menu"), title: "列表模式", handler: nil)
        let bookSelfGroupAction = PopoverAction.init(image:  UIImage(named: "right_money"), title: "书架分组", handler: nil)
        let bookSelfEditAction = PopoverAction.init(image:  UIImage(named: "right_multichat"), title: "编辑书架", handler: nil)
        return [importBookAction!, listModeAction!, bookSelfGroupAction!, bookSelfEditAction!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        if scrollView.contentOffset.y <= 170 {
            navView.headBackView.alpha = scrollView.contentOffset.y/170
            UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        } else {
            navView.headBackView.alpha = 1
            UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: true)
        }
        
        if contentOffsetY < 0 {
            var rect = backgroundImage.frame
            rect.size.height = backImageHeight - contentOffsetY
            rect.size.width = screenW * (backImageHeight - contentOffsetY)/backImageHeight
            rect.origin.x = -(rect.size.width-screenW)/2
            rect.origin.y = 0
            backgroundImage.frame = rect
        } else {
            var rect = backgroundImage.frame
            rect.size.height = backImageHeight
            rect.size.width = screenW
            rect.origin.x = 0
            rect.origin.y = -contentOffsetY
            backgroundImage.frame = rect
        }
    }
}

