//
//  BaseResponse.swift
//  CxyHub
//
//  Created by caony on 2019/4/25.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation
import HandyJSON

struct BaseResponse:HandyJSON {
    var code:Int = 0
    var message:String = ""
    var ttl:Int = 0
    var data:Any?
    // trending专用
    var count:Int = 0
    var msg:String = ""
    var items:[Any] = []
    
    init() {}
}
