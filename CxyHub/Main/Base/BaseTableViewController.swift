//
//  BaseTableViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/7.
//  Copyright © 2019年 cj. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView:UITableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needsLogin && !Login.shared.isLogin && !Login.shared.hasLogin {
            showLogin()
        }
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    private func setupSubviews() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 0.01
        tableView.sectionFooterHeight = 0.01
        view.addSubview(tableView)
    }
    
    private func register(){
        let classes = registerCellClasses()
        for cls in classes {
            self.tableView.qs_registerCellClass(cls as! UITableViewCell.Type)
        }
        let nibClasses = registerCellNibs()
        for cls in nibClasses {
            self.tableView.qs_registerCellNib(cls as! UITableViewCell.Type)
        }
        
        let headerClasses = registerHeaderViewClasses()
        for cls in headerClasses {
            self.tableView.qs_registerHeaderFooterClass(cls as! UITableViewHeaderFooterView.Type)
        }
        let footerClasses = registerFooterViewClasses()
        for cls in footerClasses {
            self.tableView.qs_registerHeaderFooterClass(cls as! UITableViewHeaderFooterView.Type)
        }
        self.tableView.qs_registerCellClass(UITableViewCell.self)
    }
    
    func registerHeaderViewClasses() -> Array<AnyClass> {
        return []
    }
    
    func registerFooterViewClasses() -> Array<AnyClass> {
        return []
    }
    
    func registerCellClasses() -> Array<AnyClass> {
        return []
    }
    
    func registerCellNibs() -> Array<AnyClass> {
        return []
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.qs_dequeueReusableCell(UITableViewCell.self)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
}

