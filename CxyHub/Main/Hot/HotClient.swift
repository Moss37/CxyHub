//
//  HotClient.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

class HotClient: BaseClient {
    
    var since:HotSince = .daily
    var lang:String = "Swift"
    
    override var api: BaseApiProtocol {
        return HotApi(lang, since: since)
    }
    
    func fetchTrending(_ handler:BaseHandler<[HotItem]>?) {
        lang = "Objective-C"
        request(api.baseURLString, method: api.method, parameters: api.parameters, encoding: api.encoding, headers: api.headers) { (response) in
            guard let responseObj = response else {
                handler?(nil)
                return
            }
            if responseObj.code == 0 {
                if let recommend = [HotItem].deserialize(from: responseObj.items) as? [HotItem] {
                    handler?(recommend)
                    return
                }
            }
            handler?(nil)
        }
    }
}
