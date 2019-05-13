//
//  LoginClient.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit
import Alamofire

class LoginClient: BaseClient {
    
    override var api: BaseApiProtocol {
        return LoginApi()
    }
    
    var accessApi:LoginAccessTokenApi {
        return LoginAccessTokenApi()
    }
    
    func fetchAccessToken(_ handler:BaseHandler<[String:String]>?) {
        postObj(accessApi.baseURLString, parameters: accessApi.parameters, encoding: URLEncoding.default, headers: accessApi.headers) { (response) in
            if let responseObj = LoginAccess.deserialize(from: response as? [String:Any]) {
                Login.shared.access = responseObj
            } else {
                // after request failed,should get authCode again
                Login.shared.authCode = ""
            }
        }
    }
    
}
