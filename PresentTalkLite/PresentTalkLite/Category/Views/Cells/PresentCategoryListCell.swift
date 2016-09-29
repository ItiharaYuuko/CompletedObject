//
//  PresentCategoryListCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/29.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class PresentCategoryListCell: UITableViewCell {

    @IBOutlet weak var coverImageViewX: UIImageView!
    @IBOutlet weak var nameLabelX: UILabel!
    @IBOutlet weak var priceLabelX: UILabel! {
        didSet {
            self.priceLabelX.textColor = ToolsX.barTintColor ;
        }
    }
    @IBOutlet weak var favoriteCountLabelX: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
