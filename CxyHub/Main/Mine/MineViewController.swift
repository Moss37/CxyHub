//
//  MineViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class MineViewController: BaseTableViewController {
    
    private let client = MineClient()
    private var user:MineUser?
    private var adapters:[String:MineAdapter] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        weak var weakSelf = self
        client.fetch { (user) in
            weakSelf?.user = user
            weakSelf?.update()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func update() {
        let userAdapter = MineAdapter()
        userAdapter.section = MineConstants.userSection
        userAdapter.cellClass = MineProfileCell.self
        userAdapter.rowHeight = MineConstants.userRowHeight
        adapters["\(userAdapter.section)"] = userAdapter
        
        let numberAdapter = MineAdapter()
        numberAdapter.section = MineConstants.numberSection
        numberAdapter.cellClass = MineNumbersCell.self
        numberAdapter.rowHeight = MineConstants.numberRowHeight
        adapters["\(numberAdapter.section)"] = numberAdapter
    }
    
    private func setupSubviews() {
        needsLogin = true
        title = "Profile"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return adapters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let adapter = adapters["\(indexPath.section)"] {
            let cell = tableView.qs_dequeueReusableCell(adapter.cellClass as! UITableViewCell.Type)
            
            return cell!
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func registerCellClasses() -> Array<AnyClass> {
        return [MineProfileCell.self,MineNumbersCell.self,UITableViewCell.self]
    }
}

class MineAdapter: HotFilterAdapterProtocol {
    var rows: [String] = []
    
    var section: Int = 0
    
    var headerHeight: CGFloat = 0.01
    
    var footerHeight: CGFloat = 0.01
    
    var rowHeight: CGFloat = 0.01
    
    weak var headerView:UIView?
    
    var headerClass:UIView.Type?
    
    var cellClass:MineCellProtocol?
    
    weak var footerView:UIView?
    
    var accessoryType:UITableViewCell.AccessoryType = .none
    
    var selectedLang:String = ""
    
    var headerText:String = ""
    
    init(_ data:[String] = []) {
        rows = data
    }
    
}

struct MineConstants {
    static let userSection = 0
    static let numberSection = 1
    static let userRowHeight:CGFloat = 100
    static let numberRowHeight:CGFloat = 60

    
}
