//
//  throughTableView.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/22.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class throughTableView: UICollectionViewCell , UITableViewDelegate , UITableViewDataSource {
    
    var dataSourceArray = NSMutableArray() ;
    
    var PushAction : Selector? ;
    
    var PushTarget : AnyObject? ;
    
    lazy var tableViewXY : UITableView = {
        let tableViewNX = UITableView(frame: CGRectMake(0, 0, ToolsX.screenWidth, ToolsX.screenHeight - 74 - 64)) ;
        tableViewNX.delegate = self ;
        tableViewNX.dataSource = self ;
        let nibX = UINib(nibName: "throughTableViewCell", bundle: nil) ;
        tableViewNX.registerNib(nibX, forCellReuseIdentifier: "throughTableViewCell") ;
        self.contentView.addSubview(tableViewNX) ;
        tableViewNX.header = MJRefreshNormalHeader(refreshingBlock: { 
            channelOffset = 0 ;
            self.dataSourceArray.removeAllObjects() ;
            self.loadData() ;
        }) ;
        tableViewNX.footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            channelOffset += 20 ;
            self.loadData() ;
        }) ;
        return tableViewNX ;
    }() ;
    
    override init(frame: CGRect) {
        super.init(frame: frame) ;
    }
    
    func setActionTarget(target : AnyObject , action : Selector) {
        self.PushTarget = target ;
        self.PushAction = action ;
    }
    
    func loadData() {
        HDManager.startLoading() ;
        self.contentView.backgroundColor = UIColor.yellowColor() ;
        TableViewCellModel.requestCellsData { (dataArray, error) in
            if error == nil {
                self.dataSourceArray.addObjectsFromArray(dataArray!) ;
            }
            else
            {
                print(error) ;
            }
            self.tableViewXY.reloadData() ;
            self.tableViewXY.header.endRefreshing() ;
            self.tableViewXY.footer.endRefreshing() ;
            HDManager.stopLoading() ;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray.count ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("throughTableViewCell", forIndexPath: indexPath) as! throughTableViewCell ;
        let modelX = self.dataSourceArray[indexPath.row] as! TableViewCellModel ;
        cell.coverImageX.sd_setImageWithURL(NSURL(string: modelX.coverImageUrl), placeholderImage: UIImage(named: "image_placeholder")) ;
        cell.likeCountLabel.text = modelX.likesCount ;
        cell.titleLabelX.text = modelX.title ;
        return cell ;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 194 ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true) ;
        let modelXZ = self.dataSourceArray[indexPath.row] as! TableViewCellModel ;
        let detialPostVC = DetialPost() ;
        detialPostVC.id = modelXZ.id ;
        detialPostVC.labelHead.text = modelXZ.title ;
        detialPostVC.imageHead.sd_setImageWithURL(NSURL(string: modelXZ.coverImageUrl)) ;
        self.PushTarget!.performSelector(self.PushAction!, withObject: detialPostVC) ;
    }
}
