//
//  ChackContentVC.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/25.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class ChackContentVC: UIViewController {

    var ccRequestUrlStr : String! ;
    
    private let webViewCCVCX = UIWebView() ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "查看内容" ;
        self.automaticallyAdjustsScrollViewInsets = true ;
        dispatch_after(1, dispatch_get_main_queue()) {
            self.configWebViewX() ;
        }
        // Do any additional setup after loading the view.
    }

    func configWebViewX() {
        self.webViewCCVCX.frame = CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64) ;
        self.view.addSubview(self.webViewCCVCX) ;
        let urlX = NSURL(string: self.ccRequestUrlStr)! ;
        let requestX = NSURLRequest(URL: urlX) ;
        self.webViewCCVCX.loadRequest(requestX) ;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
