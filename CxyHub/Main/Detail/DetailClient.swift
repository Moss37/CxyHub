//
//  DetailClient.swift
//  CxyHub
//
//  Created by caony on 2019/5/13.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

class DetailClient: BaseClient {
    
    func fetch(_ handler:BaseHandler<Detail>?) {
        let api = DetailApi(repo_path: "zhuishushenqi", repo_owner: "norycao")
        weak var weakSelf = self
        getObj(api.baseURLString, parameters: nil) { (reponse) in
            if let detail = Detail.deserialize(from: reponse as? [String:Any]) {
                let range = detail.branches_url.ocString.range(of: "{")
                
                let urlRange:Range = 0..<range.location
                let urlString = detail.branches_url.substingInRange(urlRange) ?? ""
                weakSelf?.fetch(branch: urlString, handler: { (reponse) in
                    
                })
                handler?(detail)
            } else {
                handler?(nil)
            }
        }
    }
    
    func fetch(branch:String, handler:BaseHandler<[DetailBranch]>?) {
        getObj(branch, parameters: nil) { (reponse) in
            if let branchObjes = [DetailBranch].deserialize(from: reponse as? [Any]) as? [DetailBranch] {
                
            }
        }
    }
}
