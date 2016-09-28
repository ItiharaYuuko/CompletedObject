//
//  CRVHeader.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/26.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class CRVHeader : UICollectionReusableView {
    var labelHeaderX = UILabel(frame: CGRectMake(0, 16, ToolsX.screenWidth, 20)) {
        didSet {
            self.labelHeaderX.font = UIFont.systemFontOfSize(18) ;
            self.labelHeaderX.textColor = UIColor.darkTextColor() ;
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame) ;
        self.configHeaderUI() ;
    }
    
    func configHeaderUI() {
        self.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        self.addSubview(self.labelHeaderX) ;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}