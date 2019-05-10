//
//  BaseClient.swift
//  CxyHub
//
//  Created by caony on 2019/4/27.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON

typealias BaseHandler<T> = (_ response:T?)->Void

class BaseClient {
    
    var sessionManager:SessionManager!
    
    var api:BaseApiProtocol {
        return BaseApi()
    }
}

extension BaseClient {
    
    func get(
        _ url:URLConvertible,
        parameters:[String:Any]?,
        encoding:ParameterEncoding? = URLEncoding.default,
        headers:HTTPHeaders? = nil,
        handler:BaseHandler<BaseResponse>?) {
        request(url, method: .get, parameters: parameters, encoding: encoding, headers: headers, handler: handler)
    }
    
    func post(
        _ url:String,
        parameters:[String:Any]?,
        encoding:ParameterEncoding? = URLEncoding.default,
        headers:HTTPHeaders? = nil,
        handler:BaseHandler<BaseResponse>?) {
        request(url, method: .post, parameters: parameters, encoding: encoding, headers: headers, handler: handler)
    }
    
    func getObj(
        _ url:URLConvertible,
        parameters:[String:Any]?,
        encoding:ParameterEncoding? = URLEncoding.default,
        headers:HTTPHeaders? = nil,
        handler:BaseHandler<[String:Any]>?) {
        requestObj(url, method: .get, parameters: parameters, encoding: encoding, headers: headers, handler: handler)
    }
    
    func postObj(
        _ url:String,
        parameters:[String:Any]?,
        encoding:ParameterEncoding? = URLEncoding.default,
        headers:HTTPHeaders? = nil,
        handler:BaseHandler<[String:Any]>?) {
        requestObj(url, method: .post, parameters: parameters, encoding: encoding, headers: headers, handler: handler)
    }
    
    func requestObj(
        _ url:URLConvertible,
        method:HTTPMethod = .get,
        parameters:[String:Any]?,
        encoding:ParameterEncoding? = URLEncoding.default,
        headers:HTTPHeaders? = nil,
        handler:BaseHandler<[String:Any]>?) {
        var realHeaders:HTTPHeaders = defaultHeaders()
        if let header = headers {
            realHeaders.cxy_merge(header)
        }
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        urlSessionConfiguration.timeoutIntervalForRequest = 15
        sessionManager = SessionManager(configuration: urlSessionConfiguration)
        sessionManager
            .request(url, method: method, parameters: parameters, encoding: encoding!, headers: realHeaders)
            .responseJSON { (response) in
                guard let data = response.data else {
                    handler?(nil)
                    return
                }
                if data.count == 0 {
                    handler?(nil)
                    return
                }
                do {
                    guard let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] else {
                        handler?(nil)
                        return
                    }
                    handler?(obj)
                } catch {
                    handler?(nil)
                }
        }
    }
    
    func request(
        _ url:URLConvertible,
        method:HTTPMethod = .get,
        parameters:[String:Any]?,
        encoding:ParameterEncoding? = URLEncoding.default,
        headers:HTTPHeaders? = nil,
        handler:BaseHandler<BaseResponse>?) {
        var realHeaders:HTTPHeaders = defaultHeaders()
        if let header = headers {
            realHeaders.cxy_merge(header)
        }
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        urlSessionConfiguration.timeoutIntervalForRequest = 15
        sessionManager = SessionManager(configuration: urlSessionConfiguration)
        sessionManager
            .request(url, method: method, parameters: parameters, encoding: encoding!, headers: realHeaders)
            .responseJSON { (response) in
                guard let data = response.data else {
                    handler?(nil)
                    return
                }
                if data.count == 0 {
                    handler?(nil)
                    return
                }
                do {
                    guard let obj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] else {
                        handler?(nil)
                        return
                    }
                    guard let responseObj = BaseResponse.deserialize(from: obj) else {
                        handler?(nil)
                        return
                    }
                    handler?(responseObj)
                } catch {
                    handler?(nil)
                }
        }
    }
    
    func stream(
        _ url:URLConvertible,
        method:HTTPMethod = .get,
        parameters:[String:Any]?,
        encoding:ParameterEncoding? = URLEncoding.default,
        headers:HTTPHeaders? = nil,
        handler:BaseHandler<BaseResponse>?) {
        Alamofire
            .request(url, method: method, parameters: parameters, encoding: encoding!, headers: headers)
            .responseData { (response) in
                
        }
    }
}

extension BaseClient {
    func defaultHeaders() ->[String:String] {
        var headers:[String:String] = [:
//            "Display-ID":"Z14F0F111DD723E64AF2863D6FF21F98CAF0-1556386529",
//            "Buvid":"Z14F0F111DD723E64AF2863D6FF21F98CAF0"
        ]
        headers.cxy_merge(defaultUserAgent())
        return headers
    }
    
    func defaultUserAgent() ->[String:String] {
        return [:
//            "User-Agent":"CxyHub/8470 CFNetwork/974.2.1 Darwin/18.0.0"
        ]
    }
}
