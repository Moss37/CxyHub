//
//  MineUser.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import HandyJSON

struct MineUser:HandyJSON {
    
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

//{
//    "login": "NoryCao",
//    "id": 14271074,
//    "node_id": "MDQ6VXNlcjE0MjcxMDc0",
//    "avatar_url": "https://avatars3.githubusercontent.com/u/14271074?v=4",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/NoryCao",
//    "html_url": "https://github.com/NoryCao",
//    "followers_url": "https://api.github.com/users/NoryCao/followers",
//    "following_url": "https://api.github.com/users/NoryCao/following{/other_user}",
//    "gists_url": "https://api.github.com/users/NoryCao/gists{/gist_id}",
//    "starred_url": "https://api.github.com/users/NoryCao/starred{/owner}{/repo}",
//    "subscriptions_url": "https://api.github.com/users/NoryCao/subscriptions",
//    "organizations_url": "https://api.github.com/users/NoryCao/orgs",
//    "repos_url": "https://api.github.com/users/NoryCao/repos",
//    "events_url": "https://api.github.com/users/NoryCao/events{/privacy}",
//    "received_events_url": "https://api.github.com/users/NoryCao/received_events",
//    "type": "User",
//    "site_admin": false,
//    "name": "Nory Chao",
//    "company": null,
//    "blog": "",
//    "location": null,
//    "email": null,
//    "hireable": null,
//    "bio": "Nothing is too late to do",
//    "public_repos": 50,
//    "public_gists": 0,
//    "followers": 4,
//    "following": 2,
//    "created_at": "2015-09-14T08:05:20Z",
//    "updated_at": "2019-05-10T08:31:55Z"
//}
