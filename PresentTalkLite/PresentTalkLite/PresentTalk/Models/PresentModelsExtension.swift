//
//  PresentModelsExtension.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/21.
//  Copyright © 2016年 NXT. All rights reserved.
//

import Foundation

extension controlScrollViewButtonsModel {
    class func requestChannelControlButtonData(dataReturn : (dataArray : [AnyObject]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        HttpManager.GET(ToolsX.APIForControlScrollViewButtonsString, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let buttonsObj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = buttonsObj["data"] as! NSDictionary ;
            let array = dataDic["channels"] as! [AnyObject] ;
            let dataArr = try! controlScrollViewButtonsModel.arrayOfModelsFromDictionaries(array , error : ()) ;
                dataReturn(dataArray: dataArr as [AnyObject] , error: nil) ;
        }) { (taskY, error) in
                dataReturn(dataArray: nil, error: error) ;
        }
    }
}

extension firstBannerViewButtonsModel {
    class func requestFirstBannerData(dataReturn : (dataArray : [AnyObject]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        HttpManager.GET(ToolsX.APIForSelectFirstBannerString, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let buttonsObj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = buttonsObj["data"] as! NSDictionary ;
            let bannerArray = dataDic["banners"] as! [AnyObject] ;
            let dataArray = try! firstBannerViewButtonsModel.arrayOfModelsFromDictionaries(bannerArray , error: ()) ;
            dataReturn(dataArray: dataArray as [AnyObject], error: nil) ;
            }) { (dataY, error) in
                dataReturn(dataArray: nil, error: error) ;
        }
    }
}

extension secondBannerViewButtonModel {
    class func requestSecondBannerData(dataReturn : (dataArray : [AnyObject]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        HttpManager.GET(ToolsX.APIForSelectSecondBannerString, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let buttonsObj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = buttonsObj["data"] as! NSDictionary ;
            let bannerArray = dataDic["secondary_banners"] as! [AnyObject] ;
            let dataArray = try! secondBannerViewButtonModel.arrayOfModelsFromDictionaries(bannerArray , error: ()) ;
            dataReturn(dataArray: dataArray as [AnyObject], error: nil) ;
        }) { (dataY, error) in
            dataReturn(dataArray: nil, error: error) ;
        }
    }
}

extension TableViewCellModel {
    class func requestCellsData(dataReturn : (dataArray : [AnyObject]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        let APIForTableViewCellsString = String(format: ToolsX.APIForChannelsString, arguments: [channelV,channelId,String(channelOffset)]) ;
        HttpManager.GET(APIForTableViewCellsString, parameters: nil, progress: nil, success: { (taskX, dataX) in
            let buttonsObj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = buttonsObj["data"] as! NSDictionary ;
            let bannerArray = dataDic["items"] as! [AnyObject] ;
            let dataArray = try! TableViewCellModel.arrayOfModelsFromDictionaries(bannerArray , error: ()) ;
            dataReturn(dataArray: dataArray as [AnyObject], error: nil) ;
        }) { (dataY, error) in
            dataReturn(dataArray: nil, error: error) ;
        }
    }
}

extension TableViewCellModel {
    class func requestRecommendCellsData(postId : String ,dataReturn : (dataArray : [AnyObject]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        let urlStrX = String(format: ToolsX.APIPOSTRequestRecommendString, postId) ;
        HttpManager.GET(urlStrX , parameters: nil, progress: nil, success: { (taskX, dataX) in
            let buttonsObj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = buttonsObj["data"] as! NSDictionary ;
            let bannerArray = dataDic["recommend_posts"] as! [AnyObject] ;
            //Here had a bug for KVC to conform the data there not the standard string value.
            let dataArray = try! TableViewCellModel.arrayOfModelsFromDictionaries(bannerArray , error: ()) ;
            dataReturn(dataArray: dataArray as [AnyObject], error: nil) ;
        }) { (dataY, error) in
            dataReturn(dataArray: nil, error: error) ;
            print(error) ;
        }
    }

}

extension TableViewCellModel {
    class func requestCollectionCellsData(collectionId : String ,dataReturn : (title : String? , dataArray : [AnyObject]? , error : NSError?) -> Void) {
        let HttpManager = ToolsX.HttpManagerPrepare() ;
        HttpManager.GET(String(format: ToolsX.APIForCollectionTypeString, collectionId , String(collectionOffset)) , parameters: nil, progress: nil, success: { (taskX, dataX) in
            let buttonsObj = try! NSJSONSerialization.JSONObjectWithData(dataX! as! NSData, options: .MutableContainers) as! NSDictionary ;
            let dataDic = buttonsObj["data"] as! NSDictionary ;
            let collectionTitleX = dataDic["title"] as! String ;
            let bannerArray = dataDic["posts"] as! [AnyObject] ;
            let dataArray = try! TableViewCellModel.arrayOfModelsFromDictionaries(bannerArray , error: ()) ;
            dataReturn(title : collectionTitleX , dataArray: dataArray as [AnyObject], error: nil) ;
        }) { (dataY, error) in
            dataReturn(title : nil ,dataArray: nil, error: error) ;
        }
    }
}
