//
//  SummaryTableViewNXT.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/24.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class SummaryTableViewNXT: UITableViewCell {

    @IBOutlet weak var summaryMainTableView: UITableView!
    
    var dataArraySummary = [DetailCommentTVModel]() ;
    
    var transferedId : String! ;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dispatch_after(2, dispatch_get_main_queue()) { 
            self.configTableViewSMTV() ;
        } ;
    }

    func configTableViewSMTV() {
        self.summaryMainTableView.delegate = self ;
        self.summaryMainTableView.dataSource = self ;
        let SMTVNib = UINib(nibName: "CommentTableViewCell", bundle: nil) ;
        self.summaryMainTableView.registerNib(SMTVNib, forCellReuseIdentifier: "CommentTableViewCell") ;
        DetailCommentTVModel.requestSummaryData(self.transferedId) { (dataArray, error) in
            if error == nil {
                self.dataArraySummary.appendContentsOf(dataArray!) ;
                self.summaryMainTableView.reloadData() ;
            }
            else {
                print(error!) ;
            }
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SummaryTableViewNXT : UITableViewDelegate , UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArraySummary.count ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true) ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let modelSMTVCellX = dataArraySummary[indexPath.row] ;
        let cellSMTV = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell", forIndexPath: indexPath) as! CommentTableViewCell ;
        cellSMTV.commentCTVCLX.text = modelSMTVCellX.content ;
        cellSMTV.iconCTVCX.sd_setImageWithURL(NSURL(string: modelSMTVCellX.avatarUrl) , placeholderImage: UIImage(named: "ig_profile_photo_default")) ;
        cellSMTV.nameCTVCLX.text = modelSMTVCellX.nickname ;
        cellSMTV.timeCTVCLX.text = ToolsX.timeStringTransferTime(modelSMTVCellX.createdAt) ;
        return cellSMTV ;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60 ;
    }
}