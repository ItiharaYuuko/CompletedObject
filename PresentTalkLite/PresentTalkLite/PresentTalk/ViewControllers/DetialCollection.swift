//
//  DetialCollection.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/22.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class DetialCollection: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var dataArrayX : NSMutableArray! ;
    
    lazy var tableViewCollectionPage : UITableView = {
        let tableViewXC = UITableView(frame: CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64)) ;
        tableViewXC.delegate = self ;
        tableViewXC.dataSource = self ;
        let nibY = UINib(nibName: "throughTableViewCell", bundle: nil) ;
        tableViewXC.registerNib(nibY, forCellReuseIdentifier: "throughTableViewCell") ;
        return tableViewXC ;
    }() ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareTheUI() ;
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        channelOffset = 0 ;
        pageNumber = 0 ;
        collectionOffset = 0 ;
    }
    
    func prepareTheUI() {
        self.automaticallyAdjustsScrollViewInsets = false ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
        self.view.addSubview(tableViewCollectionPage) ;
    }
}
extension DetialCollection {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrayX.count ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellX = tableView.dequeueReusableCellWithIdentifier("throughTableViewCell", forIndexPath: indexPath) as! throughTableViewCell ;
        let modelX = self.dataArrayX[indexPath.row] as! TableViewCellModel ;
        cellX.coverImageX.sd_setImageWithURL(NSURL(string: modelX.coverImageUrl) , placeholderImage: UIImage(named: "image_placeholder")) ;
        cellX.likeCountLabel.text = modelX.likesCount ;
        cellX.titleLabelX.text = modelX.title ;
        return cellX ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true) ;
        let modelY = self.dataArrayX[indexPath.row] as! TableViewCellModel ;
        let DPVC = DetialPost() ;
        DPVC.id = modelY.id ;
        DPVC.imageHead.sd_setImageWithURL(NSURL(string: modelY.coverImageUrl)) ;
        DPVC.labelHead.text = modelY.title ;
        self.navigationController?.pushViewController(DPVC, animated: true) ;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 194 ;
    }
}