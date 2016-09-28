//
//  PresentModels.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/21.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class controlScrollViewButtonsModel : JSONModel {
    var id : String! ;
    var name : String! ;
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}
class firstBannerViewButtonsModel : JSONModel {
    var imageUrl : String! ;
    var targetId : String! ;
    var type : String! ;
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}
class secondBannerViewButtonModel : JSONModel {
    var imageUrl : String! ;
    var id : String! ;
    var targetUrl : String! ;
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}
class TableViewCellModel : JSONModel {
    var coverImageUrl : String! ;
    var title : String! ;
    var url : String! ;
    var likesCount : String! ;
    var id : String! ;
    var type : String! ;
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}



