//
//  DetialPost.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/22.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class DetialPost: UIViewController {

    private var dataArray = NSMutableArray() ;
    
    var id : String! ;
    
    var titleX : String? = "攻略详情" ;
    
    let imageHead = UIImageView(frame: CGRectMake(0, 0, ToolsX.screenWidth, 194)) ;
    
    var labelHead = UILabel(frame: CGRectMake(0, 194, ToolsX.screenWidth, 86)) ;
    
    var headerHeight : CGFloat = 280 ;
    
    lazy var tableViewPost : UITableView = {
        let postTable = UITableView(frame: CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64)) ;
        postTable.delegate = self ;
        postTable.dataSource = self ;
        let nibNY = UINib(nibName: "PostDetialCell", bundle: nil) ;
        postTable.registerNib(nibNY, forCellReuseIdentifier: "PostDetialCell") ;
        postTable.tableHeaderView = self.tableViewHeaderCommend ;
        return postTable ;
    }() ;
    lazy var tableViewHeaderCommend : UIView = {
        var commendView = UIView(frame: CGRectMake(0 , 0 , ToolsX.screenWidth , self.imageHead.bounds.height + self.labelHead.bounds.height)) ;
        commendView.addSubview(self.imageHead) ;
        commendView.addSubview(self.labelHead) ;
        return commendView ;
    }() ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelHead.font = UIFont.boldSystemFontOfSize(20) ;
        self.labelHead.numberOfLines = 0 ;
        self.labelHead.lineBreakMode = .ByCharWrapping ;
        self.labelHead.textAlignment = .Center ;
        self.title = self.titleX ;
        self.dataProcess() ;
        self.prepareWebView() ;
        self.automaticallyAdjustsScrollViewInsets = false ;
        self.view.addSubview(tableViewPost) ;
    }
    
    override func viewDidDisappear(animated: Bool) {
        channelOffset = 0 ;
        pageNumber = 0 ;
        collectionOffset = 0 ;
    }
    
    func prepareWebView() {
        let headWebView = UIWebView(frame: CGRectMake(0, 280, ToolsX.screenWidth , 100)) ;
        headWebView.delegate = self ;
        let urlStrX = String(format: ToolsX.APIPOSTRequestContentString, self.id) ;
        let urlX = NSURL(string: urlStrX)! ;
        let requestX = NSURLRequest(URL: urlX) ;
        self.tableViewHeaderCommend.addSubview(headWebView) ;
        headWebView.loadRequest(requestX) ;
    }
    
    func dataProcess() {
        HDManager.startLoading() ;
        TableViewCellModel.requestRecommendCellsData(self.id) { (dataArray, error) in
            if error == nil {
                self.dataArray.addObjectsFromArray(dataArray!) ;
                self.tableViewPost.reloadData() ;
                HDManager.stopLoading() ;
            }
            else
            {
                print(error!) ;
            }
        }
    }
    
}

extension DetialPost : UITableViewDelegate , UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let modelY = self.dataArray[indexPath.row] as! TableViewCellModel ;
        let cellY = tableView.dequeueReusableCellWithIdentifier("PostDetialCell", forIndexPath: indexPath) as! PostDetialCell ;
        cellY.imageCommendX.sd_setImageWithURL(NSURL(string: modelY.coverImageUrl)) ;
        cellY.labelCommendX.text = modelY.title ;
        return cellY ;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100 ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true) ;
        let selfXDPVC = DetialPost() ;
        let modelZ = self.dataArray[indexPath.row] as! TableViewCellModel ;
        selfXDPVC.id = modelZ.id ;
        selfXDPVC.imageHead.sd_setImageWithURL(NSURL(string: modelZ.coverImageUrl)) ;
        selfXDPVC.labelHead.text = modelZ.title ;
        self.navigationController?.pushViewController(selfXDPVC, animated: true) ;
    }
}

extension DetialPost : UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.frame.size = webView.sizeThatFits(CGSizeZero) ;
        self.tableViewHeaderCommend.mj_h = webView.frame.size.height + 280 ;
        self.tableViewPost.tableHeaderView = self.tableViewHeaderCommend ;
        self.tableViewPost.reloadData() ;
    }
}