//
//  CategoryBannerCell.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/26.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class CategoryBannerCell: UICollectionViewCell {
    @IBOutlet weak var searchAllButton: UIButton! {
        didSet {
            self.searchAllButton.tag = 1111 ;
        }
    }

    @IBOutlet weak var BannerScrollView: UIScrollView! {
        didSet {
            self.BannerScrollView.showsVerticalScrollIndicator = false ;
            self.BannerScrollView.showsHorizontalScrollIndicator = false ;
        }
    }
    
    private var targetX : AnyObject! ;

    private var actionX : Selector! ;
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func settingupTargetAndAction(target : AnyObject , action : Selector) -> Void {
        self.targetX = target ;
        self.actionX = action ;
    }
    @IBAction func searchAllButtonAction(sender: UIButton) {
        self.targetX.performSelector(self.actionX, withObject: sender) ;
    }

}
