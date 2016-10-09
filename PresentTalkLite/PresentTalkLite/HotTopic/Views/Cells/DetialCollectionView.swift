//
//  DetialCollectionView.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/24.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class DetialCollectionView: UITableViewCell {
    
    var transferedId : String! ;
    
    var imageUrlArray = [String]() ;
    
    var labelTextPDVCX = "" ;
    
    lazy var PDVCCollectionViewX : UICollectionView = {
        let tmpLayout = DetailPicturesFlowLayout() ;
        let tmpCollVC = UICollectionView(frame: CGRectMake(0, 0, ToolsX.screenWidth, ToolsX.screenHeight - 114), collectionViewLayout: tmpLayout) ;
        let nibX = UINib(nibName: "LabelViewCell", bundle: nil) ;
        tmpCollVC.registerNib(nibX, forCellWithReuseIdentifier: "LabelViewCell") ;
        let nibY = UINib(nibName: "ImageViewCell", bundle: nil) ;
        tmpCollVC.registerNib(nibY, forCellWithReuseIdentifier: "ImageViewCell") ;
        tmpCollVC.delegate = self ;
        tmpCollVC.dataSource = self ;
        tmpCollVC.backgroundColor = UIColor.groupTableViewBackgroundColor() ;
        return tmpCollVC ;
    }() ;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dispatch_after(2, dispatch_get_main_queue()) { 
            self.requestPACCVData(self.transferedId) ;
        } ;
    }
    
    func requestPACCVData(id : String) {
        self.imageUrlArray.removeAll() ;
        self.labelTextPDVCX = "" ;
        let requestUrlStr = "http://www.liwushuo.com/v2/items/\(id)/content" ;
        let HttpManagerPDVCX = ToolsX.HttpManagerPrepare() ;
        HDManager.startLoading() ;
        HttpManagerPDVCX.GET(requestUrlStr, parameters: nil, progress: nil , success: { (taskX, dataX) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData , options: .MutableContainers) as! NSDictionary ;
            let dataDic = obj["data"] as! NSDictionary ;
            let strHTML = dataDic["detail_html"] as! String ;
            let strRP = strHTML.stringByReplacingOccurrencesOfString("</p>", withString: "") ;
            var strRPPArr = strRP.componentsSeparatedByString("<p>") ;
            var imageTmpArr = [String]() ;
            var strTmpArr = [String]() ;
            if !strRPPArr.isEmpty {
                if !strRPPArr.isEmpty {
                    for emptyStr in strRPPArr {
                        if emptyStr == "" {
                            strRPPArr.removeAtIndex(strRPPArr.indexOf(emptyStr)!) ;
                        }
                    }
                    if !strRPPArr.isEmpty {
                        //Get the Charactors Array from the separated string , it maby a String array for the data. It must be judged to correct type.
                        imageTmpArr.removeAll() ;
                        strTmpArr.removeAll() ;
                        for strTest in strRPPArr {
                            if strTest.containsString("img src=") {
                                imageTmpArr.append(strTest) ;
                            }
                            else {
                                strTmpArr.append(strTest) ;
                            }
                        }
                    }
                    if !imageTmpArr.isEmpty {
                        let imageStrX = imageTmpArr.popLast()?.stringByReplacingOccurrencesOfString(" alt=\"\" />", withString: "").stringByReplacingOccurrencesOfString("<img src=", withString: "").stringByReplacingOccurrencesOfString("\"", withString: "") ;
                        let imageUrlStrLastTmpArr = imageStrX!.componentsSeparatedByString(" ") ;
                        self.imageUrlArray.appendContentsOf(imageUrlStrLastTmpArr) ;
                    }
                    if !strTmpArr.isEmpty {
                        for strS in strTmpArr {
                            self.labelTextPDVCX.appendContentsOf(strS) ;
                        }
                    }
                }
            }
            HDManager.stopLoading() ;
            self.contentView.addSubview(self.PDVCCollectionViewX) ;
            self.PDVCCollectionViewX.reloadData() ;
        }) { (taskY, error) in
            HDManager.stopLoading() ;
            print(error) ;
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DetialCollectionView : UICollectionViewDelegateFlowLayout , UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUrlArray.count + 1 ;
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true) ;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellX : UICollectionViewCell! ;
        if indexPath.item == 0 {
            let cellY = collectionView.dequeueReusableCellWithReuseIdentifier("LabelViewCell", forIndexPath: indexPath) as! LabelViewCell ;
            let cellYHeight = ToolsX.calculateStringBounds(self.labelTextPDVCX, strAreaSize: CGSizeMake(ToolsX.screenWidth, 9999), strFont: cellY.webTextLabelDCCVX.font).height ;
            cellY.webTextLabelDCCVX.frame.size = CGSizeMake(ToolsX.screenWidth, cellYHeight) ;
            if self.labelTextPDVCX != "" {
                cellY.webTextLabelDCCVX.text = "\(self.labelTextPDVCX)\n" ;
            }
            else {
                cellY.webTextLabelDCCVX.textAlignment = .Center ;
                cellY.webTextLabelDCCVX.text = "无文字介绍" ;
                cellY.webTextLabelDCCVX.font = UIFont.boldSystemFontOfSize(48) ;
                cellY.webTextLabelDCCVX.textColor = UIColor.redColor() ;
            }
            cellY.resetFrame() ;
            cellX = cellY ;
        }
        else
        {
            let cellZ = collectionView.dequeueReusableCellWithReuseIdentifier("ImageViewCell", forIndexPath: indexPath) as! ImageViewCell ;
            cellZ.imageViewDCCVX.sd_setImageWithURL(NSURL(string: self.imageUrlArray[indexPath.item - 1])) ;
//            cellZ.resetFrame() ;
//            print(indexPath.row) ;
            cellX = cellZ ;
        }
        return cellX ;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == 0 {
            if self.labelTextPDVCX == "" {
                let cellSizeX = ToolsX.calculateStringBounds("无文字介绍", strAreaSize: CGSizeMake(ToolsX.screenWidth, 999), strFont: UIFont.boldSystemFontOfSize(48)) ;
                return cellSizeX ;
            }
            else
            {
            let cellHeightY = ToolsX.calculateStringBounds(self.labelTextPDVCX, strAreaSize: CGSizeMake(ToolsX.screenWidth, 9999), strFont: UIFont.systemFontOfSize(17)).height ;
            return CGSizeMake(ToolsX.screenWidth , cellHeightY) ;
            }
        }
        else
        {
            var imageX : UIImage? ;
            var imageSize : CGSize = CGSizeMake(ToolsX.screenWidth, 0) ;
            let imageUrlXC = self.imageUrlArray[indexPath.item - 1] ;
            if let imageUrlXN = NSURL(string: imageUrlXC) {
                if let imageData = try? NSData(contentsOfURL: imageUrlXN , options: .DataReadingMappedAlways) {
                    imageX = UIImage(data: imageData) ;
                    imageSize = imageX!.size ;
                }
            }
            let imageScall = imageSize.width / ToolsX.screenWidth ;
            let sizeImageCellX = CGSizeMake(ToolsX.screenWidth, imageSize.height / imageScall) ;
            return sizeImageCellX ;
        }
    }
    
}