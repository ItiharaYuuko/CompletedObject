//
//  CategorySecondLevelPageVC.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/26.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class CategorySecondLevelPageVC: UIViewController {

    private let dataArrayXN = NSMutableArray() ;
    
    @IBOutlet weak var CSLPVCTableViewX: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUIX() ;
        self.prepareDataForPage() ;
    }
    private func configUIX() {
        let nibX = UINib(nibName: "throughTableViewCell", bundle: nil) ;
        self.CSLPVCTableViewX.registerNib(nibX, forCellReuseIdentifier: "throughTableViewCell") ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
        self.CSLPVCTableViewX.delegate = self ;
        self.CSLPVCTableViewX.dataSource = self ;
        self.CSLPVCTableViewX.rowHeight = 194 ;
        self.CSLPVCTableViewX.header = MJRefreshNormalHeader(refreshingBlock: {
            channelOffset = 0 ;
            self.dataArrayXN.removeAllObjects() ;
            self.prepareDataForPage() ;
        }) ;
        self.CSLPVCTableViewX.footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            channelOffset += 20 ;
            self.prepareDataForPage() ;
        }) ;
    }
    private func prepareDataForPage() {
        channelV = "v1" ;
        HDManager.startLoading() ;
        TableViewCellModel.requestCellsData { (dataArray, error) in
            if error == nil {
                self.dataArrayXN.addObjectsFromArray(dataArray!) ;
                self.CSLPVCTableViewX.reloadData() ;
            }
            else
            {
                print(error!) ;
            }
            self.stopRefreshAndLoading() ;
        }
    }
    
    private func stopRefreshAndLoading() {
        self.CSLPVCTableViewX.header.endRefreshing() ;
        self.CSLPVCTableViewX.footer.endRefreshing() ;
        HDManager.stopLoading() ;
    }
}
extension CategorySecondLevelPageVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrayXN.count ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellX = tableView.dequeueReusableCellWithIdentifier("throughTableViewCell", forIndexPath: indexPath) as! throughTableViewCell ;
        let modelX = self.dataArrayXN[indexPath.row] as! TableViewCellModel ;
        cellX.coverImageX.sd_setImageWithURL(NSURL(string: modelX.coverImageUrl) , placeholderImage: UIImage(named: "image_placeholder")) ;
        cellX.likeCountLabel.text = modelX.likesCount ;
        cellX.titleLabelX.text = modelX.title ;
        return cellX ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true) ;
        let modelXZ = self.dataArrayXN[indexPath.row] as! TableViewCellModel ;
        let detialPostVC = DetialPost() ;
        detialPostVC.id = modelXZ.id ;
        detialPostVC.labelHead.text = modelXZ.title ;
        detialPostVC.imageHead.sd_setImageWithURL(NSURL(string: modelXZ.coverImageUrl)) ;
        detialPostVC.hidesBottomBarWhenPushed = true ;
        self.navigationController?.pushViewController(detialPostVC, animated: true) ;
    }
}

