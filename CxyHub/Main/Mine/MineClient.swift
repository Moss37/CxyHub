//
//  MineClient.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import Alamofire

class MineClient: BaseClient {
    
    override var api: BaseApiProtocol {
        return MineApi(Login.shared.access.access_token)
    }
    
    func fetchUser(_ handler:BaseHandler<MineUser>?) {
        getObj(api.baseURLString, parameters: api.parameters, encoding: URLEncoding.default, headers: api.headers) { (response) in
            if let obj = MineUser.deserialize(from: response as? [String:Any]) {
                handler?(obj)
            } else {
                handler?(nil)
            }
        }
    }
}
