//
//  EnumExtension.swift
//  CxyHub
//
//  Created by caony on 2019/5/8.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

protocol EnumeratableEnumType {
    static var allValues:[Self] { get }
    static var reversedAllValues:[Self] { get }
}

extension HotSince:EnumeratableEnumType {
    static var allValues: [HotSince] {
        return [.daily,.weekly,.monthly]
    }
    
    static var reversedAllValues: [HotSince] {
        return [.monthly,.weekly,.daily]
    }
}
