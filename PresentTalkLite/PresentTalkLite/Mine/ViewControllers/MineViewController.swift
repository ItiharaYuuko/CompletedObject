//
//  MineViewController.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/21.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configNavigationBarItem() ;
    }
    
    func configNavigationBarItem() {
        self.navigationController?.navigationBar.barTintColor = ToolsX.barTintColor ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
    }
    
}
