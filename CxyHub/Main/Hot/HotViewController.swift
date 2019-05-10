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
    
    var cell:HotCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        weak var weakSelf = self
        client.fetchTrending { (items) in
            if let hotItems = items {
                weakSelf?.items = hotItems
                weakSelf?.tableView.reloadData()
            }
        }
        cell = HotCell(style: .default, reuseIdentifier: "\(HotCell.self)")
    }
    
    private func setupSubviews() {
        let backItem = UIBarButtonItem(title: "筛选", style: .plain, target: self, action: #selector(filterAction))
        self.navigationItem.rightBarButtonItem = backItem
    }
    
    @objc
    private func filterAction() {
        let filterVC = HotFilterViewController()
        filterVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(filterVC, animated: true)
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
        let height = cell?.height(for: items[indexPath.row]) ?? 0
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func registerCellClasses() -> Array<AnyClass> {
        return [HotCell.self]
    }
}
