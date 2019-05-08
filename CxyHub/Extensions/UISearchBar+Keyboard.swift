//
//  UISearchBar+Keyboard.swift
//  CxyHub
//
//  Created by caony on 2019/5/8.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    // MARK: Public API
    
    func resignWhenKeyboardHides() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(resignFirstResponder),
            name: UIApplication.keyboardWillHideNotification,
            object: nil
        )
    }
    
}
