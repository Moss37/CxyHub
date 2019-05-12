//
//  HotApi.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import Alamofire

enum HotSince: String {
    case daily = "daily"
    case weekly = "weekly"
    case monthly = "monthly"
}

class HotApi: BaseApi {
    var lang:String = HotFilter.shared.lang
    var since:HotSince = HotFilter.shared.since
    
    override var baseURLString: String {
        return "https://trendings.herokuapp.com".appending(path)
    }
    
    override var path: String {
        return "/repo"
    }
    
    override var parameters: [String : Any]? {
        return ["lang":lang,
                "since":since.rawValue]
    }
}
