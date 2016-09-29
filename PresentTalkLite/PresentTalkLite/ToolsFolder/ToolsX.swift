//
//  ToolsX.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/21.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

var pageNumber = 0 ;
var channelV = "v2" ;
var channelId = "100" ;
var channelOffset : NSInteger = 0 ;
var collectionOffset : NSInteger = 0 ;
class ToolsX: NSObject {
    static let selectedColor = UIColor(red: CGFloat(242) / 255, green: CGFloat(55) / 255, blue: CGFloat(84) / 255, alpha: 1) ;
    static let barTintColor = UIColor(red: 1, green: 0.4, blue: 0, alpha: 1) ;
    static let screenBounds = UIScreen.mainScreen().bounds ;
    static let screenWidth = UIScreen.mainScreen().bounds.width ;
    static let screenHeight = UIScreen.mainScreen().bounds.height ;
    static let APIForControlScrollViewButtonsString = "http://api.liwushuo.com/v2/channels/preset?generation=1&gender=1" ;
    static let APIForSelectFirstBannerString = "http://api.liwushuo.com/v1/banners" ;
    static let APIForSelectSecondBannerString = "http://api.liwushuo.com/v2/secondary_banners?generation=1&gender=1" ;
    static let APIForChannelsString = "http://api.liwushuo.com/%@/channels/%@/items?offset=%@&limit=20&generation=1&gender=1" ;
    static let APIForCollectionTypeString = "http://api.liwushuo.com/v2/collections/%@/posts?generation=1&gender=1&offset=%@&limit=20" ;
    static let APIPOSTRequestContentString = "http://www.liwushuo.com/posts/%@/content" ;
    static let APIPOSTRequestRecommendString = "http://api.liwushuo.com/v2/posts/%@/recommend" ;
    static let APIHotTopicString = "http://api.liwushuo.com/v2/items?offset=%@&limit=20&generation=1&gender=1" ;
    static let APIDetialSummaryString = "http://api.liwushuo.com/v2/items/%@/comments?offset=0&limit=20" ;
    static let APISubCategoryURLString = "http://api.liwushuo.com/v2/item_subcategories/%@/items?offset=%@&limit=20"
    static let APICategoryBannerRequestString = "http://api.liwushuo.com/v1/collections?offset=%@&limit=20" ;
    static let APICategoryCollecionItemsString = "http://api.liwushuo.com/v1/channel_groups/all" ;
    static let APICategoryTreeUrlString = "http://api.liwushuo.com/v2/item_categories/tree" ;
    static let APICategoryPSPBStr = "http://api.liwushuo.com/v2/search/item_filter" ;
    static let APIPresentSelectorPageUrlStr = "http://api.liwushuo.com/v2/search/item_by_type?target=%@&scene=%@&personality=%@&price=%@&offset=%@&limit=20" ;
    class func calculateStringBounds(string : String , strAreaSize : CGSize , strFont : UIFont) -> CGSize{
        let aimString = NSString(string: string) ;
        let strSize = aimString.boundingRectWithSize(strAreaSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : strFont], context: nil).size ;
        return strSize ;
    }
    class func timeStringTransferTime(timeSecond : String) -> String {
        let timeFromX = NSDate(timeIntervalSince1970: Double(timeSecond)!) ;
        let timeZone = NSTimeZone.systemTimeZone() ;
        let interval = timeZone.secondsFromGMTForDate(timeFromX) ;
        let localDate = timeFromX.dateByAddingTimeInterval(Double(interval)) ;
        let formater = NSDateFormatter() ;
        formater.dateFormat = "MM月dd日, HH:mm" ;
        let dateStr = formater.stringFromDate(localDate) ;
        return dateStr ;
    }
    class func encodeUniCode(string:String) -> String
    {
        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())!
    }
    class func HttpManagerPrepare() -> AFHTTPSessionManager {
        let HttpManager = AFHTTPSessionManager() ;
        HttpManager.responseSerializer = AFHTTPResponseSerializer() ;
        return HttpManager ;
    }
}
