//
//  ViewController.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/21.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let controlButtonScrollViewDataArray = NSMutableArray() ;
    let firstBannerScrollViewDataArray = NSMutableArray() ;
    let secondBannerScrollViewDataArray = NSMutableArray() ;
    let tabViewDataSourceArray = NSMutableArray() ;
    lazy var controlButtonScrollView : UIScrollView = {
        let CSBScrollView = UIScrollView(frame: CGRectMake(0, 64, ToolsX.screenWidth, 30)) ;
        CSBScrollView.showsHorizontalScrollIndicator = false ;
        return CSBScrollView ;
    }() ;
    lazy var firstBannerScrollView : XTADScrollView = {
        let adScrollX = XTADScrollView(frame: CGRectMake(0 , 0 , ToolsX.screenWidth , 190)) ;
        adScrollX.infiniteLoop = true ;
        adScrollX.needPageControl = true ;
        adScrollX.placeHolderImageName = "image_placeholder" ;
        adScrollX.pageControlPositionType = pageControlPositionTypeMiddle ;
        return adScrollX ;
    }() ;
    lazy var secondControlButtonsScrollView : UIScrollView = {
        let SCBScrollView = UIScrollView(frame: CGRectMake(0, self.firstBannerScrollView.bounds.height, ToolsX.screenWidth, 170)) ;
        
        return SCBScrollView ;
    }() ;
    lazy var selectedTableViewHeaderView : UIView = {
        let selecteHeader = UIView(frame: CGRectMake(0, 0, ToolsX.screenWidth, 360)) ;
        selecteHeader.addSubview(self.secondControlButtonsScrollView) ;
        return selecteHeader ;
    }() ;
    lazy var adminCollectionView : UICollectionView = {
        let ADMLayout = UICollectionViewFlowLayout() ;
        ADMLayout.minimumInteritemSpacing = 0 ;
        ADMLayout.minimumLineSpacing = 0 ;
        ADMLayout.scrollDirection = .Horizontal ;
        ADMLayout.itemSize = CGSizeMake(ToolsX.screenWidth, ToolsX.screenHeight - 74 - 65) ;
        let ADMCV = UICollectionView(frame: CGRectMake(0, 94, ToolsX.screenWidth, ToolsX.screenHeight - 74 - 65), collectionViewLayout: ADMLayout) ;
        ADMCV.delegate = self ;
        ADMCV.dataSource = self ;
        ADMCV.pagingEnabled = true ;
        ADMCV.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        ADMCV.registerClass(throughTableView.self, forCellWithReuseIdentifier: "throughTableView") ;
        self.createFirstTimeData() ;
        return ADMCV ;
    }() ;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configTabBarItem() ;
        self.configNavigationBarItem() ;
        self.controlButtonLoad() ;
        self.dataProcesser() ;
        self.view.addSubview(self.adminCollectionView) ;
        self.automaticallyAdjustsScrollViewInsets = false ;
    }
    
    func createFirstTimeData() {
        TableViewCellModel.requestCellsData { (dataArray, error) in
            if error == nil {
                self.tabViewDataSourceArray.removeAllObjects() ;
                self.tabViewDataSourceArray.addObjectsFromArray(dataArray!) ;
            }
            else
            {
                print(error) ;
            }
            self.adminCollectionView.reloadData() ;
        }
    }
    
    func configTabBarItem() {
//        let tabBarImageNormalNameArr = ["ic_tab_gift_normal" , "ic_tab_select_normal", "ic_tab_category_normal", "ic_tab_profile_normal"] ;
//        let tabBarName = ["礼物说" , "热门" , "分类" , "我"] ;
//        If I need to add the page of mine , I have to link the tab bar in story board ,
//        and reset the two info array to the tab bar items.
        let tabBarImageNormalNameArr = ["ic_tab_gift_normal" , "ic_tab_select_normal", "ic_tab_category_normal"] ;
        let tabBarName = ["礼物说" , "热门" , "分类"] ;
        for imageNameIndex in 0 ..< tabBarImageNormalNameArr.count {
            let nameImageNormal = tabBarImageNormalNameArr[imageNameIndex] ;
            let nameImageSelected = nameImageNormal.stringByReplacingOccurrencesOfString("normal", withString: "selected") ;
            let imageNromalPath = NSBundle.mainBundle().pathForResource(nameImageNormal, ofType: "png")! ;
            let imageNormalData = NSData(contentsOfFile: imageNromalPath)! ;
            let imageSelectedPath = NSBundle.mainBundle().pathForResource(nameImageSelected, ofType: "png")! ;
            let imageSelectedData = NSData(contentsOfFile: imageSelectedPath)! ;
            let imageNormal = UIImage(data: imageNormalData , scale: 1.5)?.imageWithRenderingMode(.AlwaysOriginal) ;
            let imageSelected = UIImage(data: imageSelectedData , scale: 1.5)?.imageWithRenderingMode(.AlwaysOriginal) ;
            self.tabBarController?.viewControllers![imageNameIndex].tabBarItem.image = imageNormal! ;
            self.tabBarController?.viewControllers![imageNameIndex].tabBarItem.selectedImage = imageSelected! ;
            self.tabBarController?.viewControllers![imageNameIndex].tabBarItem.title = tabBarName[imageNameIndex] ;
            self.tabBarController?.viewControllers![imageNameIndex].tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : ToolsX.selectedColor], forState: .Selected) ;
        }
    }
    
    func configNavigationBarItem() {
        self.navigationController?.navigationBar.barTintColor = ToolsX.barTintColor ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
    }
    
    func controlButtonLoad() {
        HDManager.startLoading() ;
        controlScrollViewButtonsModel.requestChannelControlButtonData { (dataArray, error) in
            if error == nil {
                self.controlButtonScrollViewDataArray.addObjectsFromArray(dataArray!) ;
                self.controlButtonScrollView.contentSize = CGSize(width: CGFloat(self.controlButtonScrollViewDataArray.count) * 80 , height: 0) ;
                self.calculateControlButton() ;
                self.adminCollectionView.reloadData() ;
            }
            else
            {
                print(error!) ;
            }
            self.adminCollectionView.reloadData() ;
            HDManager.stopLoading() ;
        }
    }
    
    func dataProcesser() {
        HDManager.startLoading() ;
        firstBannerViewButtonsModel.requestFirstBannerData { (dataArray, error) in
            if error == nil {
                self.firstBannerScrollViewDataArray.addObjectsFromArray(dataArray!) ;
                var imageTempArray = [String]() ;
                for i in self.firstBannerScrollViewDataArray {
                    let model = i as! firstBannerViewButtonsModel ;
                    imageTempArray.append(model.imageUrl) ;
                }
                self.firstBannerScrollView.imageURLArray = imageTempArray ;
                self.selectedTableViewHeaderView.addSubview(self.firstBannerScrollView) ;
            }
            else
            {
                print(error!) ;
            }
            self.adminCollectionView.reloadData() ;
            HDManager.stopLoading() ;
        }
        secondBannerViewButtonModel.requestSecondBannerData { (dataArray, error) in
            if error == nil {
                self.secondBannerScrollViewDataArray.addObjectsFromArray(dataArray!) ;
                self.secondControlButtonsScrollView.contentSize = CGSizeMake(CGFloat(self.secondBannerScrollViewDataArray.count) * 165, 0) ;
                self.calculateSecondBannerButtons() ;
            }
            else
            {
                print(error!) ;
            }
            self.adminCollectionView.reloadData() ;
            HDManager.stopLoading() ;
        }
    }
    
    func calculateControlButton() {
        for i in 0 ..< self.controlButtonScrollViewDataArray.count {
            let model = self.controlButtonScrollViewDataArray[i] as! controlScrollViewButtonsModel ;
            let buttonX = UIButton(frame: CGRectMake(CGFloat(i) * 80, 0, 80, 30)) ;
            buttonX.setTitle(model.name!, forState: .Normal) ;
            buttonX.tag = Int(model.id)! ;
            buttonX.addTarget(self, action: #selector(self.controlButtonAction(_:)), forControlEvents: .TouchUpInside) ;
            buttonX.titleLabel?.font = UIFont.systemFontOfSize(15) ;
            buttonX.setTitleColor(UIColor.blackColor(), forState: .Normal) ;
            buttonX.setTitleColor(ToolsX.barTintColor, forState: .Selected) ;
            if i == 0 {
                buttonX.selected = true ;
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.controlButtonScrollView.addSubview(buttonX) ;
            }) ;
        }
        dispatch_async(dispatch_get_main_queue(),
        {
            self.view.addSubview(self.controlButtonScrollView) ;
        }) ;
    }
    
    func calculateSecondBannerButtons() {
        for i in 0 ..< self.secondBannerScrollViewDataArray.count {
            let modelX = self.secondBannerScrollViewDataArray[i] as! secondBannerViewButtonModel ;
            let buttonY = UIButton(frame: CGRectMake(20 + CGFloat(i) * 160, 10, 150, 150)) ;
            buttonY.layer.cornerRadius = 8 ;
            buttonY.layer.masksToBounds = true ;
            buttonY.tag = i + 40 ;
            buttonY.sd_setImageWithURL(NSURL(string: modelX.imageUrl), forState: .Normal) ;
            buttonY.addTarget(self, action: #selector(self.secondBannerButtonsAction(_:)), forControlEvents: .TouchUpInside) ;
            dispatch_async(dispatch_get_main_queue(), { 
                self.secondControlButtonsScrollView.addSubview(buttonY) ;
            }) ;
        }
    }
    
    func controlButtonAction(sender : UIButton) {
        UIView.animateWithDuration(0.25) {
            for i in sender.superview!.subviews {
                if i != sender.superview!.subviews.last {
                    let buttonXN = i as! UIButton ;
                    buttonXN.selected = false ;
                }
            }
            sender.selected = true ;
            self.adminCollectionView.contentOffset.x = CGFloat(self.controlButtonScrollView.subviews.indexOf(sender)!) * ToolsX.screenWidth ;
        } ;
        if sender.tag == 100 && sender.titleLabel!.text! == "精选" {
            channelV = "v2" ;
            channelId = "100" ;
        }
        else
        {
            channelV = "v1" ;
            channelId = String(sender.tag) ;
        }
        self.createFirstTimeData() ;
    }
    
    func secondBannerButtonsAction(sender : UIButton) {
        let index = sender.tag - 40 ;
        let modelZ = self.secondBannerScrollViewDataArray[index] as! secondBannerViewButtonModel ;
//        print(modelZ.)
        let maskFlag = modelZ.targetUrl.containsString("topic_id") ;
        if maskFlag {
            let strNXArr = modelZ.targetUrl.componentsSeparatedByString("&") ;
            let strNX = strNXArr.last! ;
            let strNYArr = strNX.componentsSeparatedByString("=") ;
            let strNY = strNYArr.last! ;
            TableViewCellModel.requestCollectionCellsData(strNY, dataReturn: { (title , dataArray, error) in
                if error == nil {
                    let collectionVC = DetialCollection() ;
                    collectionVC.dataArrayX = NSMutableArray(array: dataArray!) ;
                    collectionVC.hidesBottomBarWhenPushed = true ;
                    collectionVC.title = title! ;
                    self.navigationController?.pushViewController(collectionVC, animated: true) ;
                }
                else
                {
                    print(error!) ;
                }
            }) ;
        }
        else
        {
            let alert = UIAlertController(title: "小提示", message: "亲这个栏目当前没有新内容哦。", preferredStyle: .Alert) ;
            alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil)) ;
            self.presentViewController(alert, animated: true, completion: nil) ;
        }
    }
    
    func throughTableViewCellClicked(viewController : UIViewController) {
        viewController.hidesBottomBarWhenPushed = true ;
        self.navigationController?.pushViewController(viewController, animated: true) ;
    }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource , UIScrollViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.controlButtonScrollViewDataArray.count ;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("throughTableView", forIndexPath: indexPath) as! throughTableView ;
        cell.setActionTarget(self, action: #selector(self.throughTableViewCellClicked(_:))) ;
        channelOffset = 0 ;
        cell.dataSourceArray.removeAllObjects() ;
        cell.dataSourceArray.addObjectsFromArray(self.tabViewDataSourceArray as [AnyObject]) ;
        if channelId == "100" {
            cell.tableViewXY.tableHeaderView = self.selectedTableViewHeaderView ;
        }
        else
        {
            cell.tableViewXY.tableHeaderView = nil ;
        }
        cell.tableViewXY.reloadData() ;
        return cell ;
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let buttoncon : UIButton = self.controlButtonScrollView.subviews[Int(scrollView.contentOffset.x / ToolsX.screenWidth)] as! UIButton ;
        self.controlButtonScrollView.contentOffset.x = buttoncon.frame.origin.x ;
        self.controlButtonAction(buttoncon) ;
        if scrollView.contentOffset.x > -50 {
            self.firstBannerScrollViewDataArray.removeAllObjects() ;
            self.secondBannerScrollViewDataArray.removeAllObjects() ;
            self.dataProcesser() ;
        }
    }
}
