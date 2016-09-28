//
//  PostDetialCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/22.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class PostDetialCell: UITableViewCell {
    @IBOutlet weak var imageCommendX: UIImageView! {
        didSet {
            self.imageCommendX.layer.cornerRadius = 5 ;
            self.imageCommendX.layer.masksToBounds = true ;
        }
    }
    @IBOutlet weak var labelCommendX: UILabel! {
        didSet {
            self.labelCommendX.numberOfLines = 0 ;
            self.labelCommendX.lineBreakMode = .ByCharWrapping ;
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
