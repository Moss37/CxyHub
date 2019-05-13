//
//  String+Base64.swift
//  CxyHub
//
//  Created by caonongyun on 2019/5/12.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation

extension String {
    init ? (base64: String) {
        let pad = String(repeating: "=", count: base64.count % 4)
        let base64Padded = base64 + pad
        if let decodedData = Data(base64Encoded: base64Padded, options: NSData.Base64DecodingOptions(rawValue: 0)), let decodedString = NSString(data: decodedData, encoding: String.Encoding.utf8.rawValue) {
            self.init(decodedString)
            return
        }
        return nil
    }
    
    func fromBase64() ->String {
        if let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
            var path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
            path.append("/REMDME.md")
            let url = URL(fileURLWithPath: path)
            try? data.write(to: url)
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }
    
    /// EZSE: Cut string from range
    subscript(integerRange: Range<Int>) -> String {
        let start = self.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = self.index(startIndex, offsetBy: integerRange.upperBound)
        return String(self[start..<end])
    }
    
    //获取子字符串
    func substingInRange(_ r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.count {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    var ocString:NSString {
        return self as NSString
    }
}
