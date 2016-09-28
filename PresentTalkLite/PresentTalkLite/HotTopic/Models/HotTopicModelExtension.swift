//
//  HotTopicModelExtension.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/23.
//  Copyright © 2016年 NXT. All rights reserved.
//

import Foundation

extension HotTopicCVModelX {
    class func requestMainPageData(pageOffset : Int , rollBack : (dataArray : [HotTopicCVModelX]? , error : NSError?) ->Void) {
        var dataArrayHTX = [HotTopicCVModelX]() ;
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        let urlStrHTX = String(format: ToolsX.APIHotTopicString, String(pageOffset)) ;
        HttpManager.GET(urlStrHTX, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let object = try! NSJSONSerialization.JSONObjectWithData(dataX as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = object["data"] as! NSDictionary ;
            let itemsArray = dataDic["items"] as! [AnyObject] ;
            for itemData in itemsArray {
                let item = itemData as! NSDictionary ;
                let dataItem = item["data"] as! NSDictionary ;
                let model = HotTopicCVModelX() ;
                model.coverImageUrl = dataItem["cover_image_url"] as! String ;
                model.favoritesCount = (dataItem["favorites_count"] as! NSNumber).stringValue ;
                model.id = (dataItem["id"] as! NSNumber).stringValue ;
                model.imageUrls = dataItem["image_urls"] as! [String] ;
                model.name = dataItem["name"] as! String ;
                model.price = dataItem["price"] as! String ;
                model.purchaseUrl = dataItem["purchase_url"] as! String ;
                model.descriptionX = dataItem["description"] as! String ;
                dataArrayHTX.append(model) ;
            }
            rollBack(dataArray: dataArrayHTX, error: nil) ;
            }) { (taskY, error) in
                rollBack(dataArray: nil, error: error) ;
        }
    }
}

extension DetailCommentTVModel {
    class func requestSummaryData(transferedId : String , rollBack : (dataArray : [DetailCommentTVModel]? , error : NSError?) -> Void) {
        var tmpDataArr = [DetailCommentTVModel]() ;
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        let urlStrSTVDX = String(format: ToolsX.APIDetialSummaryString, transferedId) ;
        HttpManager.GET(urlStrSTVDX, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let object = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = object["data"] as! NSDictionary ;
            let commentsArr = dataDic["comments"] as! NSArray ;
            if commentsArr.count != 0{
                for ele in commentsArr {
                    let eleDic = ele as! NSDictionary ;
                    let modelXZ = DetailCommentTVModel() ;
                    modelXZ.content = eleDic["content"] as! String ;
                    modelXZ.createdAt = (eleDic["created_at"] as! NSNumber).stringValue ;
                    modelXZ.avatarUrl = (eleDic["user"] as! NSDictionary)["avatar_url"] as! String ;
                    modelXZ.nickname = (eleDic["user"] as! NSDictionary)["nickname"] as! String ;
                    tmpDataArr.append(modelXZ) ;
                }
            }
                rollBack(dataArray: tmpDataArr, error: nil) ;
            }) { (taskY, error) in
                rollBack(dataArray: nil, error: error) ;
        }
    }
}
