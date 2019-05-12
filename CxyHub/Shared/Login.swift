//
//  Login.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

struct Login {
    var authCode:String = ""
    
    var access:LoginAccess = LoginAccess() {
        didSet { saveAccess() }
    }
    
    var user:MineUser = MineUser() {
        didSet { saveUser() }
    }
    
    var isLogin:Bool {
        return authCode.count > 0 && access.access_token.count == 0
    }
    
    var hasLogin:Bool {
        return access.access_token.count > 0
    }
    
    private func saveAccess() {
        if let json = access.toJSON() {
            UserDefaults.standard.setValue(json, forKey: Login.accessCacheKey)
        }
    }
    
    private func saveUser() {
        if let json = user.toJSON() {
            UserDefaults.standard.setValue(json, forKey: Login.userCacheKey)
        }
    }
    
    static let accessCacheKey = "accessCacheKey"
    static let userCacheKey = "userCacheKey"

    static var shared = Login()
    private init() {
        if let json = UserDefaults.standard.value(forKey: Login.accessCacheKey) as? [String:Any] {
            if let access = LoginAccess.deserialize(from: json) {
                self.access = access
            }
        }
        if let json = UserDefaults.standard.value(forKey: Login.userCacheKey) as? [String:Any] {
            if let user = MineUser.deserialize(from: json) {
                self.user = user
            }
        }
    }
}
