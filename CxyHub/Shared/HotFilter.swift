//
//  HotFilter.swift
//  CxyHub
//
//  Created by caonongyun on 2019/5/11.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

struct HotFilter {
    
    var since:HotSince = .daily {
        didSet { saveSince() }
    }
    var lang:String = "Swift" {
        didSet { saveLang() }
    }
    
    static let sinceCacheKey = "sinceCacheKey"
    static let langCacheKey = "langCacheKey"
    static var shared = HotFilter()
    private init() {
        if let sinceValue = UserDefaults.standard.value(forKey: HotFilter.sinceCacheKey) as? String {
            if let cacheSince = HotSince(rawValue: sinceValue) {
                self.since = cacheSince
            }
        }
        if let langValue = UserDefaults.standard.value(forKey: HotFilter.langCacheKey) as? String {
            self.lang = langValue
        }
    }
    
    private func saveSince() {
        UserDefaults.standard.setValue(since.rawValue, forKey: HotFilter.sinceCacheKey)
        UserDefaults.standard.synchronize()

    }
    
    private func saveLang() {
        UserDefaults.standard.setValue(lang, forKey: HotFilter.langCacheKey)
        UserDefaults.standard.synchronize()
    }
}
