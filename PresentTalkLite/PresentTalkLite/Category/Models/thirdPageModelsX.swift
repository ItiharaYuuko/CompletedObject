//
//  thirdPageModelsX.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/26.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class AllCategoriesBannerModelX : JSONModel {
    var bannerImageUrl : String! ;
    var coverImageUrl : String! ;
    var id : String! ;
    var subtitle : String! ;
    var title : String! ;
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}

class CategoryCollectionItemsModelX : JSONModel {
    var name : String! ;
    var id : String! ;
    var channels : [CategoryChannelModelX]! ;
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}

class CategoryChannelModelX : JSONModel {
    var coverImageUrl : String! ;
    var groupId : String! ;
    var iconUrl : String! ;
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

class allCategoriesTableViewCellModel : JSONModel {
    var coverImageUrl : String! ;
    var id : String! ;
    var subtitle : String! ;
    var title : String! ;
    override class func propertyIsOptional(property:String)->Bool
    {
        return true
    }
    override class func keyMapper()->JSONKeyMapper
    {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}

class PresentCategoryTreeModel : NSObject {
    var iconUrl : String! ;
    var id : String! ;
    var name : String! ;
    var subcategories : [subcategoriesModel]! ;
}

class subcategoriesModel : NSObject {
    var iconUrl : String! ;
    var id : String! ;
    var name : String! ;
}

class presentSelectorButtonModelX : NSObject {
    var name : String! ;
    var id : String! ;
    var key : String! ;
    var channels : [PSBChannelsModelX]! ;
}

class PSBChannelsModelX : JSONModel {
    var groupId : String! ;
    var id : String! ;
    var key : String! ;
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

class PresentSelectorListModelX : NSObject {
    var coverImageUrl : String! ;
    var favoritesCount : String! ;
    var id : String! ;
    var name : String! ;
    var price : String! ;
    var Description : String! ;
}
