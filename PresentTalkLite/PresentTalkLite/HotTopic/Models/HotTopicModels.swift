//
//  HotTopicModels.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/23.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class HotTopicCVModelX: NSObject {
    var coverImageUrl : String! ;
    var favoritesCount : String! ;
    var id : String! ;
    var imageUrls : [String]! ;
    var name : String! ;
    var price : String! ;
    var purchaseUrl : String! ;
    var descriptionX : String! ;
}

class DetailCommentTVModel : NSObject {
    var content : String! ;
    var createdAt : String! ;
    var avatarUrl : String! ;
    var nickname : String! ;
}
