//
//  MineApi.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

class MineApi: BaseApi {
    var token:String = ""
    
    init(_ token:String) {
        self.token = token
    }
    
    override var baseURLString: String {
        return "https://api.github.com".appending(path)
    }
    
    override var path: String {
        return "/user"
    }
    
    override var headers: [String : String]? {
        return ["Authorization":"token \(token)"]
    }
}
