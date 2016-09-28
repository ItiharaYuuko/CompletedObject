//
//  CommentTableViewCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/23.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var iconCTVCX: UIImageView! {
        didSet {
            self.iconCTVCX.layer.cornerRadius = self.iconCTVCX.bounds.height / 2 ;
            self.iconCTVCX.layer.masksToBounds = true ;
        }
    }
    @IBOutlet weak var nameCTVCLX: UILabel!
    @IBOutlet weak var timeCTVCLX: UILabel!
    @IBOutlet weak var commentCTVCLX: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
