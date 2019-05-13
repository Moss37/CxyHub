//
//  DetailApi.swift
//  CxyHub
//
//  Created by caony on 2019/5/13.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class DetailApi: BaseApi {
    var repo_path:String = ""
    var repo_owner:String = ""
    init(repo_path:String, repo_owner:String) {
        self.repo_path = repo_path
        self.repo_owner = repo_owner
    }
    
    override var baseURLString: String {
        return "https://api.github.com".appending(path)
    }
    
    override var path: String {
        return "/repos/\(repo_owner)/\(repo_path)"
    }
}
