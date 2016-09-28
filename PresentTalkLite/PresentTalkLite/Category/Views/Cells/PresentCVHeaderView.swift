//
//  PresentCVHeaderView.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/28.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class PresentCVHeaderView: UICollectionReusableView {

    @IBOutlet weak var PresentCVHeaderTitleLabelX: UILabel!
    @IBOutlet weak var liftGrayLine: UIView! {
        didSet {
            self.liftGrayLine.layer.borderWidth = 0.5 ;
            self.liftGrayLine.layer.borderColor = UIColor.lightGrayColor().CGColor ;
        }
    }
    @IBOutlet weak var rightGrayLine: UIView! {
        didSet {
            self.rightGrayLine.layer.borderWidth = 0.5 ;
            self.rightGrayLine.layer.borderColor = UIColor.lightGrayColor().CGColor ;
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
