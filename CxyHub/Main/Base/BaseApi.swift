//
//  BaseApi.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import Alamofire

public protocol BaseApiProtocol {
    var baseURLString:String { get }
    var path:String { get }
    var parameters:[String:Any]? { get }
    var headers:[String:String]? { get }
    var method:HTTPMethod { get }
    var encoding:ParameterEncoding { get }
}

public class BaseApi:BaseApiProtocol {
    public var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var baseURLString: String {
        return ""
    }
    
    public var path: String {
        return ""
    }
    
    public var parameters: [String : Any]? {
        return nil
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
