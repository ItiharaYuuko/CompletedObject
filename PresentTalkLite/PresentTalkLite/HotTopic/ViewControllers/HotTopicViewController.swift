//
//  HotTopicViewController.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/21.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class HotTopicViewController: UIViewController {

    var hotTopicCollectionViewX : UICollectionView = {
        let layOutHT = UICollectionViewFlowLayout() ;
        layOutHT.itemSize = CGSize(width: 170, height: 200) ;
        layOutHT.minimumInteritemSpacing = 20 ;
        layOutHT.minimumLineSpacing = 15 ;
        layOutHT.sectionInset = UIEdgeInsetsMake(20, 25, 20, 25) ;
        let htCVX = UICollectionView(frame: CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 64 - 44), collectionViewLayout: layOutHT) ;
        htCVX.backgroundColor = UIColor.whiteColor() ;
        return htCVX ;
    }() ;
    
    let htDataArrayX = NSMutableArray() ;
    
    var pageOffset = 0 ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false ;
        self.configNavigationBarItem() ;
        self.prepareNetWorkData() ;
        self.configCollectionView() ;
    }
    
    func configCollectionView() {
        self.hotTopicCollectionViewX.header = MJRefreshNormalHeader(refreshingBlock: {
            self.pageOffset = 0 ;
            self.htDataArrayX.removeAllObjects() ;
            self.prepareNetWorkData() ;
        }) ;
        self.hotTopicCollectionViewX.footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            self.pageOffset += 20 ;
            self.prepareNetWorkData() ;
        }) ;
        self.hotTopicCollectionViewX.delegate = self ;
        self.hotTopicCollectionViewX.dataSource = self ;
        let nibTHX = UINib(nibName: "HotTopicMainCell", bundle: nil) ;
        self.hotTopicCollectionViewX.registerNib(nibTHX, forCellWithReuseIdentifier: "HotTopicMainCell") ;
        self.view.addSubview(self.hotTopicCollectionViewX) ;
    }
    
    func prepareNetWorkData() {
        HDManager.startLoading() ;
        HotTopicCVModelX.requestMainPageData(self.pageOffset) { (dataArray, error) in
            if error == nil {
                self.htDataArrayX.addObjectsFromArray(dataArray!) ;
                self.hotTopicCollectionViewX.reloadData() ;
                self.hotTopicCollectionViewX.header.endRefreshing() ;
                self.hotTopicCollectionViewX.footer.endRefreshing() ;
                HDManager.stopLoading() ;
            }
            else
            {
                print(error) ;
                HDManager.stopLoading() ;
            }
        }
    }
    
    func configNavigationBarItem() {
        self.navigationController?.navigationBar.barTintColor = ToolsX.barTintColor ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
    }
}

extension HotTopicViewController : UICollectionViewDelegateFlowLayout , UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.htDataArrayX.count ;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellTHX = collectionView.dequeueReusableCellWithReuseIdentifier("HotTopicMainCell", forIndexPath: indexPath) as! HotTopicMainCell ;
        let modelTHY = self.htDataArrayX[indexPath.item] as! HotTopicCVModelX ;
        let attributeText = NSMutableAttributedString(string: "♡ \(modelTHY.favoritesCount!)") ;
        attributeText.addAttributes([NSForegroundColorAttributeName : UIColor.redColor()], range: NSRange(location: 0, length: 1)) ;
        attributeText.addAttributes([NSForegroundColorAttributeName : UIColor.grayColor()], range: NSRange(location: 2, length: NSString(string: modelTHY.favoritesCount!).length)) ;
        cellTHX.htLikeCountLX.attributedText = attributeText ;
        cellTHX.htImageX.sd_setImageWithURL(NSURL(string: modelTHY.coverImageUrl)) ;
        cellTHX.htNameLX.text = modelTHY.name ;
        cellTHX.htPriceLX.text = "￥ \(modelTHY.price)" ;
        return cellTHX ;
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true) ;
        let modelTHZ = self.htDataArrayX[indexPath.item] as! HotTopicCVModelX ;
        let PDVCX = PresentDetailVC() ;
        PDVCX.adSVPDVC.imageURLArray = modelTHZ.imageUrls ;
        PDVCX.itemAimURLStr = modelTHZ.purchaseUrl ;
        PDVCX.nameLPDVC.text = modelTHZ.name ;
        PDVCX.priceLPDVC.text = "￥ \(modelTHZ.price)" ;
        PDVCX.descriptionLPDVC.text = modelTHZ.descriptionX ;
        PDVCX.transferId = modelTHZ.id ;
        PDVCX.hidesBottomBarWhenPushed = true ;
        self.navigationController?.pushViewController(PDVCX, animated: true) ;
    }
}