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
}
