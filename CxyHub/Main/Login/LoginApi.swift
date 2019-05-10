//
//  LoginApi.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class LoginApi: BaseApi {

    override var baseURLString: String {
        var parameterString:String = ""
        if let parameter = parameters {
            for item in parameter {
                if parameterString.count > 0 {
                    parameterString.append("&")
                }
                parameterString = parameterString.appending("\(item.key)=\(item.value)")
            }
        }
        if parameterString.count > 0 {
            parameterString = "?\(parameterString)"
        }
        return "https://github.com".appending(path).appending(parameterString)
    }
    
    override var path: String {
        return "/login/oauth/authorize"
    }
    
    override var parameters: [String : Any]? {
        return ["scope":"",
                "client_id":AppConstants.clientId,
                "redirect_uri":AppConstants.callbackUrl]
    }
}

class LoginAccessTokenApi:LoginApi {
    
    override var baseURLString: String {
        return "https://github.com".appending(path)
    }
    
    override var headers: [String : String]? {
        return [
                "Accept":"application/json"]
    }
    
    override var path: String {
        return "/login/oauth/access_token"
    }
    
    override var parameters: [String : Any]? {
        return ["client_id":AppConstants.clientId,
                "client_secret":AppConstants.clientSecret,
                "code":Login.shared.authCode,
                ]
    }
}
