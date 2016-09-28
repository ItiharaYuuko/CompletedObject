//
//  TableViewHFVSBB.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/24.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class TableViewHFVSBB: UITableViewHeaderFooterView {

    let buttonA = UIButton() ;
    
    let buttonB = UIButton() ;
    
    private var actionSBX : Selector! ;
    
    private var targetSBX : AnyObject! ;
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier) ;
        self.configTwoButtons() ;
    }
    
    func configTwoButtons() {
        let splViewX = UIView(frame: CGRectMake(ToolsX.screenWidth / 2 - 1, 0, 1, 42)) ;
        splViewX.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        self.buttonA.frame = CGRectMake(0, 1, ToolsX.screenWidth / 2 - 0.5, 40) ;
        self.buttonB.frame = CGRectMake(ToolsX.screenWidth / 2 + 0.5, 1, ToolsX.screenWidth / 2 - 0.5, 40) ;
        let splViewYX = UIView(frame: CGRectMake(0, 0, ToolsX.screenWidth, 1)) ;
        let splViewYY = UIView(frame: CGRectMake(0, 41, ToolsX.screenWidth, 1)) ;
        splViewYX.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        splViewYY.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        self.buttonA.setTitle("图文介绍", forState: .Normal) ;
        self.buttonA.setTitle("图文介绍", forState: .Selected) ;
        self.buttonB.setTitle("评价", forState: .Normal) ;
        self.buttonB.setTitle("评价", forState: .Selected) ;
        self.buttonA.setTitleColor(ToolsX.barTintColor, forState: .Selected) ;
        self.buttonB.setTitleColor(ToolsX.barTintColor, forState: .Selected) ;
        self.buttonA.setTitleColor(UIColor.darkTextColor(), forState: .Normal) ;
        self.buttonB.setTitleColor(UIColor.darkTextColor(), forState: .Normal) ;
        self.buttonA.backgroundColor = UIColor.whiteColor() ;
        self.buttonB.backgroundColor = UIColor.whiteColor() ;
        self.buttonA.selected = true ;
        self.buttonA.titleLabel?.font = UIFont.boldSystemFontOfSize(18) ;
        self.buttonB.titleLabel?.font = UIFont.boldSystemFontOfSize(18) ;
        self.addSubview(self.buttonA) ;
        self.addSubview(self.buttonB) ;
        self.buttonA.tag = 401 ;
        self.buttonB.tag = 402 ;
        self.buttonA.addTarget(self, action: #selector(self.selectButtonActionSBX(_:)), forControlEvents: .TouchUpInside) ;
        self.buttonB.addTarget(self, action: #selector(self.selectButtonActionSBX(_:)), forControlEvents: .TouchUpInside) ;
        self.addSubview(splViewX) ;
        self.addSubview(splViewYX) ;
        self.addSubview(splViewYY) ;
    }
    
    func setUpActionAndSelector(action : Selector , target : AnyObject) {
        self.actionSBX = action ;
        self.targetSBX = target ;
    }
    
    func selectButtonActionSBX(sender : UIButton) {
        self.targetSBX.performSelector(self.actionSBX, withObject: sender) ;
        if sender == self.buttonA {
            self.buttonB.selected = false ;
        }
        else {
            self.buttonA.selected = false ;
        }
        sender.selected = true ;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
