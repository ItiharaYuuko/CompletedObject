//
//  CSLPVCTableViewCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/27.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class CSLPVCTableViewCell: UITableViewCell {

    @IBOutlet weak var backImageViewX: UIImageView!
    @IBOutlet weak var subTitleLabelX: UILabel!
    @IBOutlet weak var titleLabelX: UILabel!
    @IBOutlet weak var cricleGrayViewX: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configViewsUI() ;
    }

    func configViewsUI() {
        self.backImageViewX.layer.cornerRadius = 8 ;
        self.backImageViewX.layer.masksToBounds = true ;
        self.cricleGrayViewX.layer.cornerRadius = self.cricleGrayViewX.bounds.height / 2 ;
        self.cricleGrayViewX.layer.masksToBounds = true ;
        self.cricleGrayViewX.layer.borderWidth = 5 ;
        self.cricleGrayViewX.layer.borderColor = UIColor.lightGrayColor().CGColor ;
        self.subTitleLabelX.lineBreakMode = .ByTruncatingTail ;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
