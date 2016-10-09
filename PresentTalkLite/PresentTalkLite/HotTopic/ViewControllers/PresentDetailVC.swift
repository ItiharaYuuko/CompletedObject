//
//  PresentDetailVC.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/23.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class PresentDetailVC: UIViewController {

    @IBOutlet weak var bottomViewPDVCX: UIView!
    @IBOutlet weak var BVPDVCLikeButtonX: UIButton! {
        didSet {
            self.BVPDVCLikeButtonX.layer.cornerRadius = self.BVPDVCLikeButtonX.bounds.height / 2 ;
            self.BVPDVCLikeButtonX.layer.masksToBounds = true ;
            self.BVPDVCLikeButtonX.layer.borderWidth = 1 ;
            self.BVPDVCLikeButtonX.layer.borderColor = ToolsX.barTintColor.CGColor ;
        }
    }
    @IBOutlet weak var BVPDVCToBuyButtonX: UIButton! {
        didSet {
            self.BVPDVCToBuyButtonX.layer.cornerRadius = self.BVPDVCLikeButtonX.bounds.height / 2 ;
            self.BVPDVCToBuyButtonX.layer.masksToBounds = true ;
        }
    }
    
    lazy var adSVPDVC : XTADScrollView = {
        let adScV = XTADScrollView(frame: CGRectMake(0, 0, ToolsX.screenWidth, 240)) ;
        adScV.infiniteLoop = true ;
        adScV.needPageControl = true ;
        adScV.pageControlPositionType = pageControlPositionTypeMiddle ;
        adScV.placeHolderImageName = "image_placeholder" ;
        return adScV ;
    }() ;
    
    lazy var tableViewPDVCX : UITableView = {
        let tmpTableView = UITableView(frame: CGRectMake(0, 64, ToolsX.screenWidth, ToolsX.screenHeight - 104)) ;
        tmpTableView.delegate = self ;
        tmpTableView.dataSource = self ;
        tmpTableView.tableHeaderView = self.PDVCTVHeaderView ;
        tmpTableView.registerClass(TableViewHFVSBB.self, forHeaderFooterViewReuseIdentifier: "TableViewHFVSBB") ;
        let nibPDVCTVX = UINib(nibName: "DetialCollectionView", bundle: nil) ;
        tmpTableView.registerNib(nibPDVCTVX, forCellReuseIdentifier: "DetialCollectionView") ;
        let nibPDVCTVY = UINib(nibName: "SummaryTableViewNXT", bundle: nil) ;
        tmpTableView.registerNib(nibPDVCTVY, forCellReuseIdentifier: "SummaryTableViewNXT") ;
        return tmpTableView ;
    }() ;
    
    let nameLPDVC = UILabel(frame: CGRectMake(20, 194 + 56, ToolsX.screenWidth - 40, 21)) ;
    
    let priceLPDVC = UILabel(frame: CGRectMake(20, 194 + 87, ToolsX.screenWidth - 40, 21)) ;
    
    let descriptionLPDVC = UILabel(frame: CGRectMake(20, 296 + 10 , ToolsX.screenWidth - 40, 84)) ;
    
    private let PDVCTVHeaderView = UIView(frame: CGRectMake(0, 64, ToolsX.screenWidth, 400)) ;
    
    var itemAimURLStr : String! ;
    
    var transferId : String! ;
    
    private var pageFlage = 401 ;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configPDVCTVHV() ;
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false ;
        self.navigationItem.title = "礼物详情" ;
        self.configNavigationShareButton() ;
    }
    
    override func viewDidDisappear(animated: Bool) {
        channelOffset = 0 ;
        pageNumber = 0 ;
        collectionOffset = 0 ;
    }
    
    private func configNavigationShareButton() {
        let buttonBarItemX = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(self.shareButtonAction(_:))) ;
        buttonBarItemX.tintColor = UIColor.whiteColor() ;
        buttonBarItemX.tag = 767 ;
        self.navigationItem.rightBarButtonItem = buttonBarItemX ;
    }
//MARK: - U-Share settingup for object.
    func shareButtonAction(BarButton : UIBarButtonItem) {
        print(BarButton.tag) ;
        //UmengShare will used at here.
    }
    
    private func configPDVCTVHV() {
        self.nameLPDVC.font = UIFont.boldSystemFontOfSize(17) ;
        self.priceLPDVC.font = UIFont.systemFontOfSize(15) ;
        self.priceLPDVC.textColor = UIColor.redColor() ;
        self.descriptionLPDVC.font = UIFont.systemFontOfSize(15) ;
        self.descriptionLPDVC.textColor = UIColor.lightGrayColor() ;
        self.descriptionLPDVC.textAlignment = .Left ;
        self.descriptionLPDVC.numberOfLines = 0 ;
        let labelHeight = ToolsX.calculateStringBounds(self.descriptionLPDVC.text!, strAreaSize: CGSizeMake(self.descriptionLPDVC.bounds.width, 9999), strFont: self.descriptionLPDVC.font).height ;
        self.descriptionLPDVC.frame.size.height = labelHeight + 10 ;
        self.PDVCTVHeaderView.addSubview(self.adSVPDVC) ;
        self.PDVCTVHeaderView.addSubview(self.nameLPDVC) ;
        self.PDVCTVHeaderView.addSubview(self.priceLPDVC) ;
        self.PDVCTVHeaderView.addSubview(self.descriptionLPDVC) ;
        self.PDVCTVHeaderView.frame.size.height = self.nameLPDVC.bounds.height + self.priceLPDVC.bounds.height + self.descriptionLPDVC.bounds.height + self.adSVPDVC.bounds.height + 30 ;
        self.PDVCTVHeaderView.layer.borderWidth = 1 ;
        self.PDVCTVHeaderView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor ;
        self.PDVCTVHeaderView.clipsToBounds = true ;
        self.view.addSubview(self.tableViewPDVCX) ;
    }

    func transferClicked(sender : UIButton) {
        self.pageFlage = sender.tag ;
        self.tableViewPDVCX.reloadData() ;
    }
    
    @IBAction func LikeBActionX(sender: UIButton) {
        let alert = UIAlertController(title: "小提示", message: "感谢亲喜欢这个礼物哦🎁。", preferredStyle: .Alert) ;
        alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil)) ;
        self.presentViewController(alert, animated: true, completion: nil) ;
    }
    

    @IBAction func ToBActionX(sender: UIButton) {
        if self.itemAimURLStr != nil {
            let ccVC = ChackContentVC() ;
            ccVC.ccRequestUrlStr = self.itemAimURLStr ;
            self.navigationController?.pushViewController(ccVC, animated: true) ;
        }
        else
        {
            let alert = UIAlertController(title: "小提示", message: "😅不好意思，此页面来的时候走迷路了，我们会尽快修复。", preferredStyle: .Alert) ;
            alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: nil)) ;
            self.presentViewController(alert, animated: true, completion: nil) ;
        }
    }
}

extension PresentDetailVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1 ;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 ;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42 ;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell! ;
        if self.pageFlage == 401 {
            let cellXR = tableView.dequeueReusableCellWithIdentifier("DetialCollectionView", forIndexPath: indexPath) as! DetialCollectionView ;
            cellXR.transferedId = self.transferId ;
            cell = cellXR ;
        }
        else if self.pageFlage == 402{
            let cellYR = tableView.dequeueReusableCellWithIdentifier("SummaryTableViewNXT", forIndexPath: indexPath) as! SummaryTableViewNXT ;
            cellYR.transferedId = self.transferId ;
            cell = cellYR ;
        }
        return cell ;
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerViewSectionX = tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableViewHFVSBB") as! TableViewHFVSBB ;
        headerViewSectionX.setUpActionAndSelector(#selector(self.transferClicked(_:)), target: self) ;
        return headerViewSectionX ;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ToolsX.screenHeight - 114 ;
    }
}
