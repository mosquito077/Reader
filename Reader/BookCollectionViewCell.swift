//
//  BookCollectionViewCell.swift
//  Reader
//
//  Created by mosquito on 2017/7/13.
//  Copyright © 2017年 mosquito. All rights reserved.
//

import UIKit
import SnapKit

class BookCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var nameLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect.zero)
        self.addSubview(imageView!)
        imageView?.snp.makeConstraints({ (make) in
            make.leading.top.equalToSuperview()
            make.width.equalTo((screenW-60)/3)
            make.height.equalTo(200.0)
        })
        
        nameLabel = UILabel(frame: CGRect.zero)
        nameLabel?.textColor = UIColor.black
        nameLabel?.textAlignment = NSTextAlignment.center
        nameLabel?.font = UIFont.systemFont(ofSize: 17.0)
        self.addSubview(nameLabel!)
        nameLabel?.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(imageView!).offset(200.0)
            make.width.equalTo((screenW-60)/3)
            make.height.equalTo(20.0)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
