//
//  ImageViewCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/24.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewDCCVX: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func resetFrame() {
        self.imageViewDCCVX.frame = self.bounds ;
    }
    
}
