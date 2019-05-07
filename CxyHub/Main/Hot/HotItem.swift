//
//  HotItem.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import HandyJSON

struct HotItem: HandyJSON {
    var repo:String = ""
    var repo_link:String = ""
    var desc:String = ""
    var lang:String = ""
    var stars:String = ""
    var forks:String = ""
    var avatars:[String] = []
    var added_stars:String = ""

    init() {}
}
