//
//  UITableViewExtension.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func qs_registerCellNib<T:UITableViewCell>(_ aClass:T.Type){
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }
    
    func qs_registerCellClass<T:UITableViewCell>(_ aClass:T.Type){
        let name = String(describing:aClass)
        self.register(aClass, forCellReuseIdentifier: name)
    }
    
    func qs_dequeueReusableCell<T:UITableViewCell>(_ aClass:T.Type)->T!{
        let name = String(describing:aClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("\(name) is not registered")
        }
        return cell
    }
    
    func qs_registerHeaderFooterNib<T:UIView>(_ aClass:T.Type){
        let name = String(describing: aClass)
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }
    
    func qs_registerHeaderFooterClass<T:UIView>(_ aClass:T.Type){
        let name = String(describing:aClass)
        self.register(aClass, forHeaderFooterViewReuseIdentifier: name)
    }
    
    func qs_dequeueReusableHeaderFooterView<T:UIView>(_ aClass:T.Type)->T!{
        let name = String(describing:aClass)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: name) as? T else {
            fatalError("\(name) is not registered")
        }
        return cell
    }
}
