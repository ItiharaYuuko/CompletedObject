//
//  PresentCSLPCVVC.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/28.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class PresentCSLPCVVC: UIViewController {
    
    private var categoryTableViewDataSourceArray = [HotTopicCVModelX]() ;
    private var presentSelectorButtonDataArray = [presentSelectorButtonModelX]() ;
    private var presentSelectorDataSourceArray = [PresentSelectorListModelX]() ;
    private var topButtonViewX = UIView(frame: CGRectMake(0, 64, ToolsX.screenWidth, 40)) ;
    private lazy var selectedTableViewX: UITableView = {
        let tmpTableView = UITableView(frame: CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64)) ;
        tmpTableView.dataSource = self ;
        tmpTableView.delegate = self ;
        let nibX = UINib(nibName: "PresentCategoryListCell", bundle: nil) ;
        tmpTableView.registerNib(nibX, forCellReuseIdentifier: "PresentCategoryListCell") ;
        return tmpTableView ;
    }() ;
    var tagX = 0 ;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
        // Do any additional setup after loading the view.
        self.configUIXCurrentButtonAndPicker() ;
    }
    
    override func viewDidDisappear(animated: Bool) {
        channelOffset = 0 ;
        pageNumber = 0 ;
        collectionOffset = 0 ;
    }
    
    private func configUIXCurrentButtonAndPicker() {
        self.view.addSubview(self.selectedTableViewX) ;
        self.selectedTableViewX.header = MJRefreshNormalHeader(refreshingBlock: {
            pageNumber = 0 ;
            if self.tagX > 0 {
                self.categoryTableViewDataSourceArray.removeAll() ;
                self.loadPCDData() ;
            }
            else
            {
                self.presentSelectorDataSourceArray.removeAll() ;
                self.loadPSLData(offset: String(pageNumber)) ;
            }
        }) ;
        self.selectedTableViewX.footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            pageNumber += 20 ;
            if self.tagX > 0 {
                self.loadPCDData() ;
            }
            else
            {
                self.loadPSLData(offset: String(pageNumber)) ;
            }
        }) ;
        self.topButtonViewX.backgroundColor = UIColor.redColor() ;
        if self.tagX > 0 {
            self.selectedTableViewX.frame = CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64) ;
        }
        else
        {
            self.view.addSubview(self.topButtonViewX) ;
            self.selectedTableViewX.frame = CGRectMake(0, 104, ToolsX.screenWidth, ToolsX.screenHeight - 104) ;
        }
        self.prepareItemListData() ;
    }
    
    private func prepareItemListData() {
        if self.tagX > 0 {
            self.loadPCDData() ;
        }
        else
        {
            self.loadPSBData() ;
            self.loadPSLData("", scene: "", personality: "", price: "", offset: "") ;
        }
    }
    
    private func loadPCDData() {
        HDManager.startLoading() ;
        HotTopicCVModelX.requestPresentCategoryDetailData(String(self.tagX), pageOffset: String(pageNumber), rollBack: { (dataArray, error) in
            if error == nil {
                self.categoryTableViewDataSourceArray.appendContentsOf(dataArray!) ;
                self.selectedTableViewX.reloadData() ;
                self.stopLoadingData() ;
            }
            else
            {
                print(error!) ;
                self.stopLoadingData() ;
            }
        }) ;
    }
    
    private func loadPSBData() {
        HDManager.startLoading() ;
        presentSelectorButtonModelX.requestSelectorButtonData({ (dataArray, error) in
            if error == nil {
                self.presentSelectorButtonDataArray.appendContentsOf(dataArray!) ;
                self.stopLoadingData() ;
            }
            else
            {
                print(error!) ;
                self.stopLoadingData() ;
            }
        }) ;
    }
    
    private func loadPSLData(target : String! = "", scene : String! = "" , personality : String! = "" , price : String! = "" , offset : String! = "") {
        HDManager.startLoading() ;
        PresentSelectorListModelX.requestPresentSelectorPageData(target , scene: scene , personality: personality , price: price , offset: offset) { (dataArr, error) in
            if error == nil {
                self.presentSelectorDataSourceArray.appendContentsOf(dataArr!) ;
                self.selectedTableViewX.reloadData() ;
                self.stopLoadingData() ;
            }
            else
            {
                print(error!) ;
                self.stopLoadingData() ;
            }
        }
    }
    
    private func stopLoadingData() {
        self.selectedTableViewX.header.endRefreshing() ;
        self.selectedTableViewX.footer.endRefreshing() ;
        HDManager.stopLoading() ;
    }
    
}

extension PresentCSLPCVVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tagX > 0 {
            return self.categoryTableViewDataSourceArray.count ;
        }
        else
        {
            return self.presentSelectorDataSourceArray.count ;
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.tagX > 0 {
            let modelRX = self.categoryTableViewDataSourceArray[indexPath.row] ;
            let cellX = tableView.dequeueReusableCellWithIdentifier("PresentCategoryListCell", forIndexPath: indexPath) as! PresentCategoryListCell ;
            cellX.coverImageViewX.sd_setImageWithURL(NSURL(string: modelRX.coverImageUrl)) ;
            cellX.nameLabelX.text = modelRX.name ;
            cellX.priceLabelX.text = modelRX.price ;
            let attributeText = NSMutableAttributedString(string: "♡ \(modelRX.favoritesCount!)") ;
            attributeText.addAttributes([NSForegroundColorAttributeName : ToolsX.barTintColor], range: NSRange(location: 0, length: 1)) ;
            attributeText.addAttributes([NSForegroundColorAttributeName : UIColor.grayColor()], range: NSRange(location: 2, length: NSString(string: modelRX.favoritesCount).length)) ;
            cellX.favoriteCountLabelX.attributedText = attributeText ;
            return cellX ;
        }
        else
        {
            let modelRY = self.presentSelectorDataSourceArray[indexPath.row] ;
            let cellY = tableView.dequeueReusableCellWithIdentifier("PresentCategoryListCell", forIndexPath: indexPath) as! PresentCategoryListCell ;
            cellY.coverImageViewX.sd_setImageWithURL(NSURL(string: modelRY.coverImageUrl)) ;
            cellY.nameLabelX.text = modelRY.name ;
            cellY.priceLabelX.text = modelRY.price ;
            let attributeText = NSMutableAttributedString(string: "♡ \(modelRY.favoritesCount!)") ;
            attributeText.addAttributes([NSForegroundColorAttributeName : ToolsX.barTintColor], range: NSRange(location: 0, length: 1)) ;
            attributeText.addAttributes([NSForegroundColorAttributeName : UIColor.grayColor()], range: NSRange(location: 2, length: NSString(string: modelRY.favoritesCount).length)) ;
            cellY.favoriteCountLabelX.attributedText = attributeText ;
            return cellY ;
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ToolsX.screenWidth + 50 ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true) ;
    }
    
}
