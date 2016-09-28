//
//  CategoryViewController.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/21.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    private var bannerDataArry = [AllCategoriesBannerModelX]() ;
    
    private var categoryCollectionDataArray = [CategoryCollectionItemsModelX]() ;
    
    private var presentCellDataSource = [PresentCategoryTreeModel]() ;
    
    @IBOutlet weak var categorySegment: UISegmentedControl! {
        didSet {
            self.categorySegment.tintColor = UIColor.whiteColor() ;
        }
    }
    
    @IBOutlet weak var categoryMainScrollView: UIScrollView! {
        didSet {
            self.categoryMainScrollView.contentSize = CGSizeMake(ToolsX.screenWidth * 2, 0) ;
            self.categoryMainScrollView.pagingEnabled = true ;
            self.categoryMainScrollView.backgroundColor = UIColor.whiteColor() ;
            self.categoryMainScrollView.bounces = false ;
            self.categoryMainScrollView.delegate = self ;
        }
    }
    
    private lazy var categoryCollectionViewX : UICollectionView = {
        let tmpLayout = UICollectionViewFlowLayout() ;
        tmpLayout.minimumLineSpacing = 8 ;
        tmpLayout.minimumInteritemSpacing = 5 ;
        tmpLayout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12) ;
        let tmpCollectionView = UICollectionView(frame: CGRectMake(0, 0, ToolsX.screenWidth, ToolsX.screenHeight - 113) , collectionViewLayout: tmpLayout) ;
        let nibX = UINib(nibName: "CategoryBannerCell", bundle: nil) ;
        tmpCollectionView.registerNib(nibX, forCellWithReuseIdentifier: "CategoryBannerCell") ;
        let nibY = UINib(nibName: "CategoryItemCell", bundle: nil) ;
        tmpCollectionView.registerNib(nibY, forCellWithReuseIdentifier: "CategoryItemCell") ;
        tmpCollectionView.registerClass(CRVHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CRVHeader") ;
        tmpCollectionView.delegate = self ;
        tmpCollectionView.dataSource = self ;
        return tmpCollectionView ;
    }();
    
    private lazy var presentItemTableViewX : UITableView = {
        let tmpTableView = UITableView(frame: CGRectMake(0, 40, ToolsX.screenWidth / 4, ToolsX.screenHeight - 148)) ;
        tmpTableView.delegate = self ;
        tmpTableView.dataSource = self ;
        tmpTableView.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        return tmpTableView ;
    }() ;
    
    private lazy var presentItemCollectionViewX : UICollectionView = {
        let tmpLayout = UICollectionViewFlowLayout() ;
        tmpLayout.minimumLineSpacing = 2 ;
        tmpLayout.minimumInteritemSpacing = 2 ;
        tmpLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10) ;
        tmpLayout.itemSize = CGSizeMake(75, 98) ;
        let tmpCollectionView = UICollectionView(frame: CGRectMake(ToolsX.screenWidth / 4, 40, ToolsX.screenWidth - ToolsX.screenWidth / 4, ToolsX.screenHeight - 148), collectionViewLayout: tmpLayout) ;
        let nibR = UINib(nibName: "PresentItemCell", bundle: nil) ;
        tmpCollectionView.registerNib(nibR, forCellWithReuseIdentifier: "PresentItemCell") ;
        let nibRX = UINib(nibName: "PresentCVHeaderView", bundle: nil) ;
        tmpCollectionView.registerNib(nibRX, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "PresentCVHeaderView") ;
        tmpCollectionView.backgroundColor = UIColor.whiteColor() ;
        tmpCollectionView.delegate = self ;
        tmpCollectionView.dataSource = self ;
        return tmpCollectionView ;
    }() ;
    
    private var presentHarfOfScrollView = UIView(frame: CGRectMake(ToolsX.screenWidth, 0, ToolsX.screenWidth , ToolsX.screenHeight - 108)) ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigationBarItem() ;
        self.configScrollViewX() ;
        self.configHarfScrollViewContentView() ;
        self.preparePageData() ;
        self.preparePresentPageData() ;
    }
    
    private func preparePageData() {
        HDManager.startLoading() ;
        pageNumber = 0 ;
        AllCategoriesBannerModelX.requestCategoryBannerData(pageNumber) { (dataArray, error) in
            if error == nil {
                self.bannerDataArry.appendContentsOf(dataArray!) ;
                self.categoryCollectionViewX.reloadData() ;
                self.stopRefreshingEndLoading() ;
            }
            else
            {
                self.stopRefreshingEndLoading() ;
                print(error!) ;
            }
        }
        CategoryCollectionItemsModelX.requestCategoryCollectionItemsData { (dataArray, error) in
            if error == nil {
                self.categoryCollectionDataArray.appendContentsOf(dataArray!) ;
                self.stopRefreshingEndLoading() ;
            }
            else
            {
                self.stopRefreshingEndLoading() ;
                print(error) ;
            }
        }
    }
    
    private func preparePresentPageData() {
        PresentCategoryTreeModel.requestCategoryTreeData { (dataArr, error) in
            if error == nil {
                self.presentCellDataSource.appendContentsOf(dataArr!) ;
                self.presentItemTableViewX.reloadData() ;
                self.presentItemCollectionViewX.reloadData() ;
            }
            else
            {
                print(error!) ;
            }
        }
    }
    
    private func stopRefreshingEndLoading() {
        HDManager.stopLoading() ;
        self.categoryCollectionViewX.header.endRefreshing() ;
    }
    
    func selectPresentAction(sender : UIButton) {
        print(sender.tag) ;
    }
    
    private func configHarfScrollViewContentView() {
        let buttonViewX = UIView(frame: CGRectMake(0, 0, ToolsX.screenWidth, 40)) ;
        let labelTrangle = UILabel(frame: CGRectMake(ToolsX.screenWidth - 20, 0, 20 , 40)) ;
        labelTrangle.text = "▶︎" ;
        labelTrangle.textColor = UIColor.lightGrayColor() ;
        labelTrangle.font = UIFont.boldSystemFontOfSize(17) ;
        let labelCircle = UILabel(frame: CGRectMake(5, 5, 30, 30)) ;
        labelCircle.layer.cornerRadius = 15 ;
        labelCircle.layer.masksToBounds = true ;
        labelCircle.backgroundColor = UIColor.greenColor() ;
        labelCircle.textColor = UIColor.whiteColor() ;
        labelCircle.text = "☭" ;
        labelCircle.font = UIFont.boldSystemFontOfSize(24) ;
        labelCircle.textAlignment = .Center ;
        let buttonX = UIButton(frame: CGRectMake(40, 0, ToolsX.screenWidth - 60 , 40)) ;
        buttonX.addTarget(self, action: #selector(self.selectPresentAction(_:)), forControlEvents: .TouchUpInside) ;
        buttonX.titleLabel?.font = UIFont.systemFontOfSize(17) ;
        buttonX.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, ToolsX.screenWidth - 160) ;
        buttonX.setTitleColor(UIColor.blackColor(), forState: .Normal) ;
        buttonX.setTitle("选礼神器", forState: .Normal) ;
        buttonX.tag = -7 ;
        buttonViewX.addSubview(buttonX) ;
        buttonViewX.addSubview(labelTrangle) ;
        buttonViewX.backgroundColor = UIColor.whiteColor() ;
        buttonViewX.addSubview(labelCircle) ;
        self.presentHarfOfScrollView.addSubview(buttonViewX) ;
        self.presentHarfOfScrollView.backgroundColor = UIColor.whiteColor() ;
        self.presentHarfOfScrollView.addSubview(self.presentItemCollectionViewX) ;
        self.presentHarfOfScrollView.addSubview(self.presentItemTableViewX) ;
        self.categoryMainScrollView.addSubview(self.presentHarfOfScrollView) ;
    }
    
    private func configScrollViewX() {
        self.categoryCollectionViewX.header = MJRefreshNormalHeader(refreshingBlock: {
            self.bannerDataArry.removeAll() ;
            self.categoryCollectionDataArray.removeAll() ;
            self.preparePageData() ;
        }) ;
        self.categoryMainScrollView.alwaysBounceHorizontal = false ;
        self.categoryMainScrollView.alwaysBounceVertical = false ;
        self.categoryCollectionViewX.backgroundColor = UIColor.whiteColor() ;
        self.categoryMainScrollView.addSubview(self.categoryCollectionViewX) ;
    }
    
    private func configNavigationBarItem() {
        self.automaticallyAdjustsScrollViewInsets = false ;
        self.navigationController?.navigationBar.barTintColor = ToolsX.barTintColor ;
    }
    
    @IBAction func categorySegmentAction(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.2, animations: { 
                self.categoryMainScrollView.contentOffset.x = 0 ;
            }) ;
        }
        else
        {
            UIView.animateWithDuration(0.2, animations: { 
                self.categoryMainScrollView.contentOffset.x = ToolsX.screenWidth ;
            }) ;
        }
    }
    
    func bannerButtonsActionX(sender : UIButton) {
        if sender.tag != 1111 {
            let modelX = self.bannerDataArry[sender.tag - 77] ;
            TableViewCellModel.requestCollectionCellsData(modelX.id) { (title, dataArray, error) in
                if error == nil {
                    let detailCVVC = DetialCollection() ;
                    let mutableArr = NSMutableArray(array: dataArray!) ;
                    detailCVVC.dataArrayX = mutableArr ;
                    detailCVVC.title = title! ;
                    detailCVVC.hidesBottomBarWhenPushed = true ;
                    self.navigationController?.pushViewController(detailCVVC, animated: true) ;
                }
                else
                {
                    print(error!) ;
                }
            }
        }
        else
        {
            let searchAllVC = SearchAllButtonVC() ;
            searchAllVC.hidesBottomBarWhenPushed = true ;
            self.navigationController?.pushViewController(searchAllVC, animated: true) ;
        }
    }
    
}
extension CategoryViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / ToolsX.screenWidth) ;
        self.categorySegment.selectedSegmentIndex = index ;
    }
}
extension CategoryViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if collectionView == self.categoryCollectionViewX {
            return self.categoryCollectionDataArray.count + 1 ;
        }
        else
        {
            return self.presentCellDataSource.count ;
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoryCollectionViewX {
            if section == 0 {
                return 1 ;
            }
            else
            {
                let dataArrayX = self.categoryCollectionDataArray[section - 1] ;
                return dataArrayX.channels.count ;
            }
        }
        else
        {
            let mainArr = self.presentCellDataSource[section].subcategories
            return mainArr.count ;
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true) ;
        if collectionView == self.categoryCollectionViewX {
            if indexPath.section == 0 {
                print(indexPath.item) ;
            }
            else
            {
                let dataArrayX = self.categoryCollectionDataArray[indexPath.section - 1] ;
                let model = dataArrayX.channels[indexPath.row] ;
                let CSLVCX = CategorySecondLevelPageVC() ;
                channelId = model.id ;
                CSLVCX.title = model.name ;
                CSLVCX.hidesBottomBarWhenPushed = true ;
                self.navigationController?.pushViewController(CSLVCX, animated: true) ;
            }
        }
        else
        {
            let modelR = self.presentCellDataSource[indexPath.section].subcategories[indexPath.item] ;
            print(modelR.name) ;
            let pcslpcvvc = PresentCSLPCVVC() ;
            pcslpcvvc.title = modelR.name ;
            pcslpcvvc.tagX = Int(modelR.id)! ;
            pcslpcvvc.hidesBottomBarWhenPushed = true ;
            self.navigationController?.pushViewController(pcslpcvvc, animated: true) ;
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == self.categoryCollectionViewX {
            if indexPath.section == 0 {
                let cellX = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryBannerCell", forIndexPath: indexPath) as! CategoryBannerCell ;
                cellX.BannerScrollView.contentSize = CGSizeMake(CGFloat(self.bannerDataArry.count) * 130 + 10, 0) ;
                cellX.settingupTargetAndAction(self, action: #selector(self.bannerButtonsActionX(_:))) ;
                for i in 0 ..< self.bannerDataArry.count {
                    let modelX = self.bannerDataArry[i] ;
                    let button = UIButton(frame: CGRectMake(CGFloat(i) * 130 + 10, 0, 120, 58.8)) ;
                    button.tag = i + 77 ;
                    button.sd_setImageWithURL(NSURL(string: modelX.bannerImageUrl), forState: .Normal) ;
                    button.layer.cornerRadius = 5 ;
                    button.layer.masksToBounds = true ;
                    button.addTarget(self, action: #selector(self.bannerButtonsActionX(_:)), forControlEvents: .TouchUpInside) ;
                    cellX.BannerScrollView.addSubview(button) ;
                }
                return cellX ;
            }
            else
            {
                let cellY = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryItemCell", forIndexPath: indexPath) as! CategoryItemCell ;
                let modelAY = self.categoryCollectionDataArray[indexPath.section - 1] ;
                let modelY = modelAY.channels[indexPath.item] ;
                cellY.coverImageX.sd_setImageWithURL(NSURL(string: modelY.coverImageUrl)) ;
                cellY.nameLabelX.text = modelY.name ;
                return cellY ;
            }
        }
        else
        {
            let cellZ = collectionView.dequeueReusableCellWithReuseIdentifier("PresentItemCell", forIndexPath: indexPath) as! PresentItemCell ;
            let modelZ = self.presentCellDataSource[indexPath.section].subcategories[indexPath.item] ;
            cellZ.imageViewPICX.sd_setImageWithURL(NSURL(string: modelZ.iconUrl)) ;
            cellZ.nameLabelPICX.text = modelZ.name.componentsSeparatedByString("/").first! ;
            return cellZ ;
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == self.categoryCollectionViewX {
            if indexPath.section == 0 {
                return CGSizeMake(ToolsX.screenWidth, 90) ;
            }
            else
            {
                return CGSizeMake(85, 103) ;
            }
        }
        else
        {
            return CGSize(width: 75, height: 98) ;
        }
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if collectionView == self.categoryCollectionViewX {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "CRVHeader", forIndexPath: indexPath) as! CRVHeader ;
            header.labelHeaderX.backgroundColor = UIColor.whiteColor() ;
            if indexPath.section != 0 {
                let modelX = self.categoryCollectionDataArray[indexPath.section - 1] ;
                header.labelHeaderX.text = "\t\(modelX.name)" ;
                header.labelHeaderX.frame = CGRectMake(0, 20, ToolsX.screenWidth, 22) ;
                return header ;
            }
            else
            {
                header.labelHeaderX.text = "\t专题" ;
                header.labelHeaderX.frame = CGRectMake(0, 10, ToolsX.screenWidth - 200 , 23) ;
                return header ;
            }
        }
        else
        {
            let headerX = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "PresentCVHeaderView", forIndexPath: indexPath) as! PresentCVHeaderView ;
            let modelR = self.presentCellDataSource[indexPath.section] ;
            headerX.PresentCVHeaderTitleLabelX.text = modelR.name ;
            return headerX ;
        }
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == self.categoryCollectionViewX {
            if section == 0 {
                return CGSizeMake(ToolsX.screenWidth, 1) ;
            }
            else
            {
                return CGSizeMake(ToolsX.screenWidth , 31) ;
            }
        }
        else
        {
            return CGSizeMake(self.presentItemCollectionViewX.bounds.width, 20) ;
        }
    }
}

extension CategoryViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presentCellDataSource.count ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("PresentSectionName") ;
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "PresentSectionName") ;
        }
        cell?.textLabel?.font = UIFont.systemFontOfSize(14) ;
        cell?.textLabel?.textColor = UIColor.darkTextColor() ;
        cell?.textLabel?.text = self.presentCellDataSource[indexPath.row].name ;
        cell?.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        return cell! ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cellX = tableView.cellForRowAtIndexPath(indexPath) ;
        cellX?.textLabel?.textColor = ToolsX.barTintColor ;
        if ToolsX.screenWidth == 320 {
            let offsetArr : [CGFloat] = [0.0, 428.0, 1056.0, 1684.0, 2112.0, 2740.0, 3068.0, 3596.0, 4624.0, 5152.0, 5280.0, 5608.0, 6636.0, 7164.0, 7692.0, 8220.0, 8448.0] ;
            self.presentItemCollectionViewX.contentOffset.y = offsetArr[indexPath.row] ;
        }
        else
        {
            let offsetArr : [CGFloat] = [0.0 , 328.0 , 756.0 , 1184.0 , 1512.0 , 1940.0 , 2168.0 , 2496.0 , 3224.0 , 3552.0 , 3680.0 , 3908.0 , 4636.0 , 4964.0 , 5292.0 , 5620.0 , 5848.0] ;
            self.presentItemCollectionViewX.contentOffset.y = offsetArr[indexPath.row] ;
        }
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cellY = tableView.cellForRowAtIndexPath(indexPath) ;
        cellY?.textLabel?.textColor = UIColor.darkTextColor() ;
    }
}
