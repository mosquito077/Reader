//
//  BookShelfViewController.swift
//  Reader
//
//  Created by mosquito on 2017/7/12.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit
import SnapKit

class BookShelfViewController: UIViewController, UIPopoverPresentationControllerDelegate, NavViewProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ReaderViewControllerDelegate{
    
    let backgroundHeight: CGFloat = 200
    let navViewHeight: CGFloat = 64
    
    var backgroundImage: UIImageView!
    var headImageView: UIImageView!
    var mainCollectionView: UICollectionView!
    var navView: NavView!
    
    var backImageHeight: CGFloat = 200
    
    var dataArray = [["txt小说","novel"],
                     ["pdf文档","book"]]

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
        mainCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        mainCollectionView.backgroundColor = UIColor.clear
        mainCollectionView.isScrollEnabled = true
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
            make.height.equalTo(screenH)
        }
        
    }
    
    //MARK - collectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionViewCell
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.white.cgColor
        cell.imageView?.image = UIImage(named: dataArray[indexPath.row][1])
        cell.nameLabel?.text = dataArray[indexPath.row][0]
        return cell
        
    }
    
    //返回HeaderView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        return CGSize(width: screenW, height: 136.0)
    }
    
    //返回自定义的HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", for: indexPath as IndexPath)
        headView.backgroundColor = UIColor.clear
        return headView

    }
    
    //返回cell 上下左右的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 10, 5, 10)
    }
    
    //点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            print("阅读pdf文档")
            let pdfPaths = Bundle.main.paths(forResourcesOfType: "pdf", inDirectory: nil)
            let pdfPath = pdfPaths.first
            let document = ReaderDocument.withDocumentFilePath(pdfPath, password: nil)
            if (document != nil) {
                let readVC = ReaderViewController.init(readerDocument: document)
                readVC?.delegate = self
                readVC?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                readVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                self.present(readVC!, animated: true, completion: nil)
            }
            
        } else {
            let pageView: LSYReadPageViewController = LSYReadPageViewController.init()
            let fileURL = Bundle.main.url(forResource: "note", withExtension: ".txt")
            pageView.resourceURL = fileURL
            pageView.model = LSYReadModel.getLocalModel(with: fileURL) as! LSYReadModel
            self.present(pageView, animated: true, completion: nil)
            print("阅读txt小说")
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
    
    func navRightButtonClick() {
        let popVC = PopTableViewController()
        popVC.modalPresentationStyle = UIModalPresentationStyle.popover
        popVC.popoverPresentationController?.sourceView = navView.rightBtn
        popVC.popoverPresentationController?.sourceRect = navView.rightBtn.bounds
        popVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        popVC.popoverPresentationController?.delegate = self
        popVC.popoverPresentationController?.backgroundColor = UIColor.white
        present(popVC, animated: true, completion: nil)
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

