//
//  HotClient.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

class HotClient: BaseClient {
    
    override var api: BaseApiProtocol {
        return HotApi()
    }
    
    func fetchTrending(_ handler:BaseHandler<[HotItem]>?) {
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
    
    func fetchLang(_ handler:BaseHandler<[String]>?) {
        let langApi = HotTrendingLangApi()
        request(langApi.baseURLString, method: langApi.method, parameters: langApi.parameters, encoding: langApi.encoding, headers: langApi.headers) { (response) in
            guard let responseObj = response else {
                handler?(nil)
                return
            }
            if responseObj.code == 0 {
                if let langs = responseObj.items as? [String] {
                    handler?(langs)
                    return
                }
            }
            handler?(nil)
        }
    }
}
