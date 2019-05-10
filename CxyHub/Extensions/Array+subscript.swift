//
//  Array+subscript.swift
//  CxyHub
//
//  Created by caony on 2019/5/10.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

extension Array where Element:Comparable {
    
    func index(of object:Element) ->Int? {
        let indexs = indexes(of: object)
        return indexs.first
    }
    
    func indexes(of object:Element) ->[Int] {
        return enumerated().compactMap { ($0.element == object) ? $0.offset : nil }
    }
}

extension Array where Element:Equatable {
    func index(of object:Element) ->Int? {
        let indexs = indexes(of: object)
        return indexs.first
    }
    
    func indexes(of object:Element) ->[Int] {
        return enumerated().compactMap { ($0.element == object) ? $0.offset : nil }
    }
}

extension Optional where Wrapped == String {
    var isBlank:Bool {
        return self?.count == 0
    }
    
    var string:String {
        return self ?? ""
    }
}

extension Optional {
    func or<T>(defaultValue: T) -> T {
        switch(self) {
        case .none:
            return defaultValue
        case .some(let value):
            return value as! T
        }
    }
}

public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

