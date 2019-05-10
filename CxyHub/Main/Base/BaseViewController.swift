//
//  BaseViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var needsLogin:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.white
        let backItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(popAction))
        self.navigationItem.backBarButtonItem = backItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needsLogin && !Login.shared.isLogin && !Login.shared.hasLogin {
            showLogin()
        }
    }
    
    @objc
    func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showLogin() {
        let loginVC = LoginViewController()
        weak var weakSelf = self
        loginVC.failureHandler = {
            guard let tabVC = weakSelf?.tabBarController as? TabBarViewController else {
                return
            }
            tabVC.selectedIndex = tabVC.lastSelectedIndex
        }
        present(loginVC, animated: true, completion: nil)
    }
    
    //MARK: - progress
    func showProgress() {
        self.indicatorView.center = self.view.center
        self.view.addSubview(self.indicatorView)
        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    func hideProgress() {
        self.indicatorView.stopAnimating()
        self.indicatorView.removeFromSuperview()
    }
    
    lazy var indicatorView:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.frame = CGRect(x: view.bounds.width/2 - 50 , y: view.bounds.height/2 - 50, width: 100, height: 100)
        indicator.startAnimating()
        return indicator
    }()
}
