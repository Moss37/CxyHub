//
//  MineUser.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import HandyJSON

struct MineUser:HandyJSON,MineRowProtocol {
    
    var login:String = ""
    var id:Int64 = 0
    var node_id:String = ""
    var avatar_url:String = ""
    var gravatar_id:String = ""
    var url:String = ""
    var html_url:String = ""
    var followers_url:String = ""
    var following_url:String = ""
    var gists_url:String = ""
    var starred_url:String = ""
    var subscriptions_url:String = ""
    var organizations_url:String = ""
    var repos_url:String = ""
    var events_url:String = ""
    var received_events_url:String = ""
    var type:String = ""
    var site_admin:Bool = false
    var name:String = ""
    var company:String = ""
    var blog:String = ""
    var location:String = ""
    var email:String = ""
    var hireable:String = ""
    var bio:String = ""
    var public_repos:Int = 0
    var public_gists:Int = 0
    var followers:Int = 0
    var following:Int = 0
    var created_at:String = ""
    var updated_at:String = ""


    init() {}
}

struct MineOther:MineRowProtocol {
    var title:String = ""
    var image:String = ""
}
