//
//  thirdPageModelsXExtensions.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/26.
//  Copyright © 2016年 NXT. All rights reserved.
//

import Foundation

extension AllCategoriesBannerModelX {
    class func requestCategoryBannerData(pageOffset : Int, rollBack : (dataArray : [AllCategoriesBannerModelX]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        let requestURLStr = String(format: ToolsX.APICategoryBannerRequestString, String(pageOffset)) ;
        HttpManager.GET(requestURLStr, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = obj["data"] as! NSDictionary ;
            let collectionArr = dataDic["collections"] as! [AnyObject] ;
            let dataArray = try! AllCategoriesBannerModelX.arrayOfModelsFromDictionaries(collectionArr , error:  ()) ;
            var tmpArr = [AllCategoriesBannerModelX]() ;
            for i in dataArray {
                let modelX = i as! AllCategoriesBannerModelX ;
                tmpArr.append(modelX) ;
            }
            rollBack(dataArray: tmpArr , error: nil) ;
            }) { (taskY, error) in
                rollBack(dataArray: nil, error: error) ;
        }
    }
}

extension CategoryCollectionItemsModelX {
    class func requestCategoryCollectionItemsData(rollBack : (dataArray : [CategoryCollectionItemsModelX]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        HttpManager.GET(ToolsX.APICategoryCollecionItemsString, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataArr = obj["data"] as! NSDictionary ;
            let channelGroupsArr = dataArr["channel_groups"] as! [AnyObject] ;
            var mutableChannelsArr = [CategoryCollectionItemsModelX]() ;
            let modelArr = try! CategoryCollectionItemsModelX.arrayOfModelsFromDictionaries(channelGroupsArr , error: ()) ;
            for i in modelArr {
                let modelY = i as! CategoryCollectionItemsModelX ;
                let channelsArr = modelY.channels as [AnyObject] ;
                let tmpCArrX = try! CategoryChannelModelX.arrayOfModelsFromDictionaries(channelsArr , error : ()) ;
                let modelZ = CategoryCollectionItemsModelX() ;
                modelZ.id = modelY.id ;
                modelZ.name = modelY.name ;
                var tmpCArrY = [CategoryChannelModelX]() ;
                for j in tmpCArrX {
                    let modelA = j as! CategoryChannelModelX ;
                    tmpCArrY.append(modelA) ;
                }
                modelZ.channels = tmpCArrY ;
                mutableChannelsArr.append(modelZ) ;
            }
            rollBack(dataArray: mutableChannelsArr, error: nil) ;
            }) { (taskY, error) in
                rollBack(dataArray: nil, error: error) ;
        }
    }
}

extension allCategoriesTableViewCellModel {
    class func requestAllSearchPageData(pageOffset : Int , rollBack : (dataArray : [allCategoriesTableViewCellModel]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        let requestURLStr = String(format: ToolsX.APICategoryBannerRequestString, String(pageOffset)) ;
        HttpManager.GET(requestURLStr, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            var tmpDataArr = [allCategoriesTableViewCellModel]() ;
            let dicX = obj["data"] as! NSDictionary ;
            let tmpArrDic = dicX["collections"] as! [AnyObject] ;
            let arrNew = try! allCategoriesTableViewCellModel.arrayOfModelsFromDictionaries(tmpArrDic, error: ()) ;
            for i in arrNew {
                let model = i as! allCategoriesTableViewCellModel ;
                tmpDataArr.append(model) ;
            }
            rollBack(dataArray: tmpDataArr, error: nil) ;
            }) { (taskY , error) in
                rollBack(dataArray: nil, error: error) ;
        }
    }
}

extension PresentCategoryTreeModel {
    class func requestCategoryTreeData(rollBack : (dataArr : [PresentCategoryTreeModel]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        HttpManager.GET(ToolsX.APICategoryTreeUrlString, parameters: nil, progress: nil, success: { (taskX , dataX) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = obj["data"] as! NSDictionary ;
            let categoriesArr = dataDic["categories"] as! [AnyObject] ;
            var tmpArrPCTM = [PresentCategoryTreeModel]() ;
            for elementX in categoriesArr {
                let modelPCTM = PresentCategoryTreeModel() ;
                let elementDic = elementX as! NSDictionary ;
                modelPCTM.iconUrl = elementDic["icon_url"] as! String ;
                modelPCTM.id = (elementDic["id"] as! NSNumber).stringValue ;
                modelPCTM.name = elementDic["name"] as! String ;
                var tmpArrSCM = [subcategoriesModel]() ;
                let subCategoriesArr = elementDic["subcategories"] as! [AnyObject] ;
                for elementY in subCategoriesArr {
                    let modelSCM = subcategoriesModel() ;
                    let elementDicSCM = elementY as! NSDictionary;
                    modelSCM.iconUrl = elementDicSCM["icon_url"] as! String ;
                    modelSCM.id = (elementDicSCM["id"] as! NSNumber).stringValue ;
                    modelSCM.name = elementDicSCM["name"] as! String ;
                    tmpArrSCM.append(modelSCM) ;
                }
                modelPCTM.subcategories = tmpArrSCM ;
                tmpArrPCTM.append(modelPCTM) ;
            }
            rollBack(dataArr: tmpArrPCTM, error: nil) ;
            }) { (taskY, error) in
                rollBack(dataArr: nil, error: error) ;
        }
    }
}

extension HotTopicCVModelX {
    class func requestPresentCategoryDetailData(itemId : String , pageOffset : String , rollBack : (dataArray : [HotTopicCVModelX]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        let urlStr = String(format: ToolsX.APISubCategoryURLString , "\(itemId)" , "\(pageOffset)") ;
        HttpManager.GET(urlStr, parameters: nil, progress: nil, success: { (taskX, dataX) in
            var tmpArr = [HotTopicCVModelX]() ;
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = obj["data"] as! NSDictionary ;
            let itemsArr = dataDic["items"] as! NSArray ;
            for elementX in itemsArr {
                let elementDic = elementX as! NSDictionary ;
                let modelX = HotTopicCVModelX() ;
                modelX.coverImageUrl = elementDic["cover_image_url"] as! String ;
                modelX.descriptionX = elementDic["description"] as! String ;
                modelX.favoritesCount = (elementDic["favorites_count"] as! NSNumber).stringValue ;
                modelX.id = (elementDic["id"] as! NSNumber).stringValue ;
                modelX.imageUrls = elementDic["image_urls"] as! [String] ;
                modelX.name = elementDic["name"] as! String ;
                modelX.price = elementDic["price"] as! String! ;
                modelX.purchaseUrl = elementDic["purchase_url"] as! String ;
                tmpArr.append(modelX) ;
            }
            rollBack(dataArray: tmpArr, error: nil) ;
            }) { (taskY, error) in
                rollBack(dataArray: nil, error: error) ;
        }
    }
}

extension presentSelectorButtonModelX {
    class func requestSelectorButtonData(rollBack : (dataArray : [presentSelectorButtonModelX]? , error : NSError?) -> Void) {
        let urlStrX = ToolsX.APICategoryPSPBStr ;
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        HttpManager.GET(urlStrX, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = obj["data"] as! NSDictionary ;
            let filtersArr = dataDic["filters"] as! [AnyObject] ;
            var dataArrayTransfer = [presentSelectorButtonModelX]() ;
            for eleDic in filtersArr {
                let eleDicX = eleDic as! NSDictionary ;
                let modelX = presentSelectorButtonModelX() ;
                var chennalsArrayTmp = [PSBChannelsModelX]() ;
                modelX.id = (eleDicX["id"] as! NSNumber).stringValue ;
                modelX.key = eleDicX["key"] as! String ;
                modelX.name = eleDicX["name"] as! String ;
                let tmpArrCH = eleDicX["channels"] as! [AnyObject] ;
                let arrChX = try! PSBChannelsModelX.arrayOfModelsFromDictionaries(tmpArrCH, error: ()) ;
                for ele in arrChX {
                    let model = ele as! PSBChannelsModelX ;
                    chennalsArrayTmp.append(model) ;
                }
                modelX.channels = chennalsArrayTmp ;
                dataArrayTransfer.append(modelX) ;
            }
            rollBack(dataArray: dataArrayTransfer, error: nil) ;
            }) { (dataY, error) in
                rollBack(dataArray: nil, error: error) ;
        }
    }
}

extension PresentSelectorListModelX {
    class func requestPresentSelectorPageData(target : String! = "", scene : String! = "" , personality : String! = "" , price : String! = "" , offset : String! = "",rollBack : (dataArr : [PresentSelectorListModelX]? , error : NSError?) -> Void) {
        let urlStr = String(format: ToolsX.APIPresentSelectorPageUrlStr, target , scene , personality , price , offset) ;
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        //target,&scene,personality,&price,&offset,
        HttpManager.GET(urlStr, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let obj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData , options: .MutableContainers) as! NSDictionary ;
            var transferArr = [PresentSelectorListModelX]() ;
            let dataDic = obj["data"] as! NSDictionary ;
            let itemsArrTmp = dataDic["items"] as! [AnyObject] ;
            for ele in itemsArrTmp {
                let dicEle = ele as! NSDictionary ;
                let modelXR = PresentSelectorListModelX() ;
                modelXR.coverImageUrl = dicEle["cover_image_url"] as! String ;
                modelXR.Description = dicEle["description"] as! String ;
                modelXR.favoritesCount = (dicEle["favorites_count"] as! NSNumber).stringValue ;
                modelXR.id = (dicEle["id"] as! NSNumber).stringValue ;
                modelXR.name = dicEle["name"] as! String ;
                modelXR.price = dicEle["price"] as! String ;
                transferArr.append(modelXR) ;
            }
            rollBack(dataArr: transferArr , error: nil) ;
            }) { (taskY, error) in
                rollBack(dataArr: nil, error: error) ;
        }
    }
}











