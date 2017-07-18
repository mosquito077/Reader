//
//  NavView.swift
//  Reader
//
//  Created by mosquito on 2017/7/13.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit
import SnapKit

let buttonWidthAndHeight = 44.0
let buttonsMargin = 2.0

protocol NavViewProtocol: class {
    func navLeftButtonClick()
    func navRightButtonClick(sender: UIButton)
}

class NavView: UIView {
    
    weak var navViewDelegate: NavViewProtocol?
    
    var headBackView: UIImageView!
    var titleLabel: UILabel!
    var leftBtn: UIButton!
    var rightBtn: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        headBackView = UIImageView(frame: CGRect.zero)
        headBackView.backgroundColor = UIColor.colorWithHexString(hex: "162D77")
        headBackView.alpha = 0.0
        self.addSubview(headBackView)
        headBackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(frame.size.height)
        }
        
        titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "书架"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 18.0)
        titleLabel.textColor = UIColor.white
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(46.0)
            make.trailing.equalToSuperview().offset(-46.0)
            make.top.equalToSuperview().offset(20.0)
            make.height.equalTo(buttonWidthAndHeight)
        }
        
        leftBtn = UIButton(type: UIButtonType.custom)
        leftBtn.frame = CGRect.zero
        leftBtn.backgroundColor = UIColor.clear
        leftBtn.setTitle("三", for: UIControlState.normal)
        leftBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        leftBtn.addTarget(self, action: #selector(leftButtonClick), for: UIControlEvents.touchUpInside)
        self.addSubview(leftBtn)
        
        leftBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(20.0)
            make.width.equalTo(buttonWidthAndHeight)
            make.height.equalTo(buttonWidthAndHeight)
        }
        
        rightBtn = UIButton.init(type: UIButtonType.custom)
        rightBtn.frame = CGRect.zero
        rightBtn.backgroundColor = UIColor.clear
        rightBtn.setTitle("＋", for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(rightButtonClick(sender:)), for: UIControlEvents.touchUpInside)
        self.addSubview(rightBtn)
        
        rightBtn.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(20.0)
            make.width.equalTo(buttonWidthAndHeight)
            make.height.equalTo(buttonWidthAndHeight)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leftButtonClick() {
        navViewDelegate?.navLeftButtonClick()
    }
    
    func rightButtonClick(sender:UIButton?) {
        navViewDelegate?.navRightButtonClick(sender: sender!)
    }


}
