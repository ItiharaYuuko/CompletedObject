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
    private lazy var topButtonViewX : UIView = {
        let tempViewX = UIView(frame: CGRectMake(0, 64, ToolsX.screenWidth, 40)) ;
        return tempViewX ;
    }() ;
    private lazy var selectedTableViewX: UITableView = {
        let tmpTableView = UITableView(frame: CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64)) ;
        tmpTableView.dataSource = self ;
        tmpTableView.delegate = self ;
        let nibX = UINib(nibName: "PresentCategoryListCell", bundle: nil) ;
        tmpTableView.registerNib(nibX, forCellReuseIdentifier: "PresentCategoryListCell") ;
        return tmpTableView ;
    }() ;
    private lazy var topPickerViewX : UIPickerView = {
        let tmpPickerViewX = UIPickerView(frame: CGRectMake(0, 104, ToolsX.screenWidth , 200)) ;
        tmpPickerViewX.delegate = self ;
        tmpPickerViewX.dataSource = self ;
//        tmpPickerViewX.hidden = true ;
        tmpPickerViewX.center.y = -204
        tmpPickerViewX.backgroundColor = UIColor.whiteColor() ;
        return tmpPickerViewX ;
    }() ;
    var tagX = 0 ;
    private var target = ""
    private var scene = ""
    private var personality = ""
    private var price = ""
    private var offset = ""
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
    
    private func configButtonsOnTopViewX() {
        var n = 0 ;
        for eleBDX in self.presentSelectorButtonDataArray {
            let tmpButtonX = UIButton(frame: CGRectMake(CGFloat(n) * (ToolsX.screenWidth / 4), 0 , ToolsX.screenWidth / 4, 40)) ;
            tmpButtonX.setTitle(eleBDX.name, forState: .Normal) ;
            tmpButtonX.tag = 13 + n ;
            tmpButtonX.addTarget(self, action: #selector(self.topButtonsActionX(_:)), forControlEvents: .TouchUpInside) ;
            tmpButtonX.layer.borderWidth = 1 ;
            tmpButtonX.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor ;
            tmpButtonX.setTitleColor(UIColor.blackColor(), forState: .Normal) ;
            tmpButtonX.setTitleColor(ToolsX.barTintColor, forState: .Highlighted) ;
            self.topButtonViewX.addSubview(tmpButtonX) ;
            n += 1 ;
        }
    }
    
    func topButtonsActionX(button : UIButton) {
        if self.topPickerViewX.center.y != 204 {
            UIView.animateWithDuration(0.5) {
                self.topPickerViewX.center.y = 204 ;
            }
        }
        else
        {
            UIView.animateWithDuration(0.5) {
                self.topPickerViewX.center.y = -204 ;
            } ;
            self.selectedTableViewX.header.beginRefreshing() ;
        }
        
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
                self.loadPSLData(self.target, scene: self.scene, personality: self.personality, price: self.price, offset: String(pageNumber)) ;
            }
        }) ;
        self.selectedTableViewX.footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            pageNumber += 20 ;
            if self.tagX > 0 {
                self.loadPCDData() ;
            }
            else
            {
                self.loadPSLData(self.target, scene: self.scene, personality: self.personality, price: self.price, offset: String(pageNumber)) ;
            }
        }) ;
        self.topButtonViewX.backgroundColor = UIColor.whiteColor() ;
        if self.tagX > 0 {
            self.selectedTableViewX.frame = CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64) ;
        }
        else
        {
            self.view.addSubview(self.topButtonViewX) ;
            self.view.addSubview(self.topPickerViewX) ;
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
            self.loadPSLData(self.target, scene: self.scene, personality: self.personality, price: self.price, offset: String(pageNumber)) ;
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
                self.topPickerViewX.reloadAllComponents() ;
                self.configButtonsOnTopViewX() ;
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

extension PresentCSLPCVVC : UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate {
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
        if self.tagX > 0 {
            let modelRNX = self.categoryTableViewDataSourceArray[indexPath.row] ;
            HotTopicCVModelX.requestThirdPageNextLevelPageData(modelRNX.id) { (dataModel, error) in
                if error == nil {
                    let persentDVC = PresentDetailVC() ;
                    persentDVC.adSVPDVC.imageURLArray = dataModel!.imageUrls ;
                    persentDVC.descriptionLPDVC.text = dataModel!.descriptionX ;
                    persentDVC.priceLPDVC.text = "￥ \(dataModel!.price!)" ;
                    persentDVC.nameLPDVC.text = dataModel!.name ;
                    persentDVC.itemAimURLStr = dataModel!.purchaseUrl ;
                    persentDVC.transferId = dataModel!.id ;
                    persentDVC.hidesBottomBarWhenPushed = true ;
                    self.navigationController?.pushViewController(persentDVC, animated: true) ;
                }
                else
                {
                    print(error!) ;
                }
            }
        }
        else
        {
            let modelRNX = self.presentSelectorDataSourceArray[indexPath.row] ;
            HotTopicCVModelX.requestThirdPageNextLevelPageData(modelRNX.id) { (dataModel, error) in
                if error == nil {
                    let persentDVC = PresentDetailVC() ;
                    persentDVC.adSVPDVC.imageURLArray = dataModel!.imageUrls ;
                    persentDVC.descriptionLPDVC.text = dataModel!.descriptionX ;
                    persentDVC.priceLPDVC.text = "￥ \(dataModel!.price!)" ;
                    persentDVC.nameLPDVC.text = dataModel!.name ;
                    persentDVC.itemAimURLStr = dataModel!.purchaseUrl ;
                    persentDVC.transferId = dataModel!.id ;
                    persentDVC.hidesBottomBarWhenPushed = true ;
                    self.navigationController?.pushViewController(persentDVC, animated: true) ;
                }
                else
                {
                    print(error!) ;
                }
            }
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.5) {
            self.topPickerViewX.center.y = -204 ;
        } ;
    }
}

extension PresentCSLPCVVC : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return self.presentSelectorButtonDataArray.count ;
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let currentChannel = self.presentSelectorButtonDataArray[component].channels ;
        return currentChannel.count + 1 ;
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44 ;
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return ToolsX.screenWidth / 4 - 10 ;
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let componetModelX = self.presentSelectorButtonDataArray[component] ;
        let pickerViewLabelX = UILabel(frame: CGRectMake(0, 0, ToolsX.screenWidth / 4 - 12 , 40)) ;
        pickerViewLabelX.font = UIFont.systemFontOfSize(17) ;
        pickerViewLabelX.textAlignment = .Center ;
        if row == 0 {
            pickerViewLabelX.text = "全部" ;
        }
        else
        {
            pickerViewLabelX.text = componetModelX.channels[row - 1].name ;
        }
        return pickerViewLabelX ;
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.selectRow(row, inComponent: component, animated: true) ;
        let componetModelY = self.presentSelectorButtonDataArray[component].channels ;
        switch component {
        case 0 :
            if row == 0 {
                self.target = "" ;
            }
            else
            {
                self.target = componetModelY[row - 1].key ;
            }
        case 1 :
            if row == 0 {
                self.scene = "" ;
            }
            else
            {
                self.scene = componetModelY[row - 1].key ;
            }
        case 2 :
            if row == 0 {
                self.personality = "" ;
            }
            else
            {
                self.personality = componetModelY[row - 1].key ;
            }
        default :
            if row == 0 {
                self.price = "" ;
            }
            else
            {
                self.price = componetModelY[row - 1].key ;
            }
        }
    }
}
