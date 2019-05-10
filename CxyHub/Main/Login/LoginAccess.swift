//
//  LoginAccess.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import HandyJSON

struct LoginAccess: HandyJSON {
    var token_type:String = ""
    var scope:String = ""
    var access_token:String = ""
    
    init() {}
}
