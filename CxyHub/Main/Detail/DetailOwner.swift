//
//  Detail.swift
//  CxyHub
//
//  Created by caony on 2019/5/13.
//  Copyright © 2019年 cj. All rights reserved.
//

import HandyJSON
import Foundation

struct DetailOwner: HandyJSON {
      var site_admin: Bool =  false 
      var gists_url: String =  "" 
      var repos_url: String =  "" 
      var login: String =  "" 
      var starred_url: String =  "" 
      var following_url: String =  "" 
      var events_url: String =  "" 
      var organizations_url: String =  "" 
      var type: String =  "" 
      var followers_url: String =  "" 
      var html_url: String =  "" 
      var avatar_url: String =  "" 
      var gravatar_id: String =  "" 
      var id: Int =  0 
      var url: String =  "" 
      var received_events_url: String =  "" 
      var node_id: String =  "" 
      var subscriptions_url: String =  ""
    
    init() {}
}
