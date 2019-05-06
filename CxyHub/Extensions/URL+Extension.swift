//
//  URL+Extension.swift
//  bili-universal
//
//  Created by caony on 2019/4/28.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation

extension URL {
    func decode() ->URL {
        let urlStr = self.absoluteString
        let decodeString = urlStr.removingPercentEncoding ?? ""
        let url = URL(string: decodeString) ?? self
        return url
    }
}
