//
//  throughTableViewCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/22.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class throughTableViewCell: UITableViewCell {

    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var coverImageX: UIImageView! {
        didSet {
            self.coverImageX.layer.cornerRadius = 10 ;
            self.coverImageX.layer.masksToBounds = true ;
        }
    }
    @IBOutlet weak var titleLabelX: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
