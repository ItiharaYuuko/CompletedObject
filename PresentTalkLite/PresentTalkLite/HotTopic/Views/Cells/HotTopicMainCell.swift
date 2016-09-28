//
//  HotTopicMainCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/23.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class HotTopicMainCell: UICollectionViewCell {

    @IBOutlet weak var htImageX: UIImageView!
    @IBOutlet weak var htNameLX: UILabel!
    @IBOutlet weak var htPriceLX: UILabel!
    @IBOutlet weak var htLikeCountLX: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 8 ;
        self.contentView.layer.masksToBounds = true ;
        self.contentView.layer.borderWidth = 1 ;
        self.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor ;
        self.contentView.backgroundColor = UIColor.whiteColor() ;
    }

}
