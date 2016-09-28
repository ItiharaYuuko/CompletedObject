//
//  CategoryItemCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/26.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {

    @IBOutlet weak var coverImageX: UIImageView! {
        didSet {
            self.coverImageX.layer.cornerRadius = self.coverImageX.bounds.height / 2 ;
            self.coverImageX.layer.masksToBounds = true ;
        }
    }
    @IBOutlet weak var nameLabelX: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
