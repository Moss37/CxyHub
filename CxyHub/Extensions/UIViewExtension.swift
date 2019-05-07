//
//  UIView+Extension.swift
//  CxyHub
//
//  Created by caony on 2019/4/30.
//  Copyright © 2019年 CJ. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
