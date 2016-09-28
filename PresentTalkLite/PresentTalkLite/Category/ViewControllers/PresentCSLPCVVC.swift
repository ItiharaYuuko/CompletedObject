//
//  PresentCSLPCVVC.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/28.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class PresentCSLPCVVC: UIViewController {
    @IBOutlet weak var topButtonViewX: UIView!
    lazy var selectedTableViewX: UITableView = {
        let tmpTableView = UITableView(frame: CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64)) ;
        return tmpTableView ;
    }() ;
    var arr = Array(count: 100, repeatedValue: "妈个鸡") ;
    var tagX = 0 ;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
        // Do any additional setup after loading the view.
        self.configUIXCurrentButtonAndPicker() ;
    }
    
    private func configUIXCurrentButtonAndPicker() {
        if self.tagX > 0 {
            self.topButtonViewX.hidden = true ;
            self.selectedTableViewX.frame = CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64) ;
            self.selectedTableViewX.dataSource = self ;
            self.selectedTableViewX.delegate = self ;
            self.view.addSubview(self.selectedTableViewX) ;
            print("\(self.tagX) : \(self.selectedTableViewX)") ;
        }
        else
        {
            print(self.tagX) ;
        }
    }
    
}

extension PresentCSLPCVVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("arr") ;
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "arr") ;
        }
        cell?.textLabel?.text = self.arr[indexPath.row] ;
        return cell! ;
    }
}
