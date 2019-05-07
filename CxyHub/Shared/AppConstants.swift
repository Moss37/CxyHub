//
//  AppConstants.swift
//  CxyHub
//
//  Created by caony on 2019/4/25.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation
import UIKit

public enum AppBuildChannel: String {
    
    case release   = "release"
    case beta      = "beta"
    case developer = "developer"
}

public struct AppConstants {
    public static let scheme: String = {
        guard let identifier = Bundle.main.bundleIdentifier else {
            return "unknown"
        }
        let scheme = identifier.replacingOccurrences(of: "CJ.", with: "")
        if scheme == "" {
            return scheme
        }
        return scheme
    }()
    
    public static let appKey: String = "27eb53fc9058f8c3"
    
    public static let appSecret: String = "c2ed53a74eeefe3cf99fbd01d8c9c375"
}

