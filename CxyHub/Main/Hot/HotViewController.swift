//
//  HotViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class HotViewController: BaseTableViewController {
    
    var client:HotClient = HotClient()
    
    var items:[HotItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        weak var weakSelf = self
        client.fetchTrending { (items) in
            if let hotItems = items {
                weakSelf?.items = hotItems
                weakSelf?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.qs_dequeueReusableCell(HotCell.self)
        cell?.selectionStyle = .none
        cell?.bind(items[indexPath.row])
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func registerCellClasses() -> Array<AnyClass> {
        return [HotCell.self]
    }
}
