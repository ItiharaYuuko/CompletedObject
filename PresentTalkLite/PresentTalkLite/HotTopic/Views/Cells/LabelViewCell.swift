//
//  LabelViewCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/24.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class LabelViewCell: UICollectionViewCell {

    @IBOutlet weak var webTextLabelDCCVX: UILabel! {
        didSet {
            self.webTextLabelDCCVX.backgroundColor = UIColor.whiteColor() ;
            self.webTextLabelDCCVX.textAlignment = .Left ;
            self.webTextLabelDCCVX.numberOfLines = 0 ;
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func resetFrame() {
        self.webTextLabelDCCVX.frame = self.bounds ;
    }
    
}
