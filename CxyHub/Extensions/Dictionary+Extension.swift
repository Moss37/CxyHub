//
//  Dictionary+Extension.swift
//  bili-universal
//
//  Created by caonongyun on 2019/4/27.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge<S>(_ dict:S)
        where S:Sequence, S.Iterator.Element == (key: Key,value: Value) {
            for (k,v) in dict {
                self[k] = v
            }
    }
    
    func allKeys()->[String]{
        let dict = self as NSDictionary
        let allKeys = dict.allKeys as! [String]
        return allKeys
    }
}
