//
//  HotTrendingLangApi.swift
//  CxyHub
//
//  Created by caony on 2019/5/8.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

class HotTrendingLangApi:BaseApi {
    override var baseURLString: String {
        return "https://trendings.herokuapp.com".appending(path)
    }
    
    override var path: String {
        return "/lang"
    }
}
