//
//  BaseViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.white
        let backItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(popAction))
        self.navigationItem.backBarButtonItem = backItem
        hidesBottomBarWhenPushed = true
    }
    
    @objc func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
}
