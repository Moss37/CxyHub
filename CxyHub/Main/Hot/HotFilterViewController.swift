//
//  HotFilterViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/8.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class HotFilterViewController: BaseTableViewController {
    
    var segmentView:UISegmentedControl = UISegmentedControl(frame: .zero)
    var searchBar:UISearchBar = UISearchBar(frame: .zero)
    var client:HotClient = HotClient()
    var items:[String] = []
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        weak var weakSelf = self
        client.fetchLang { (items) in
            weakSelf?.items = items ?? []
            weakSelf?.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    private func setupSubviews() {
        segmentView.tintColor = UIColor(red: 0.31, green: 0.38, blue: 0.45, alpha: 1.00)
        for item in HotSince.reversedAllValues {
            segmentView.insertSegment(withTitle: item.rawValue, at: 0, animated: false)
        }
        segmentView.selectedSegmentIndex = 0
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.clear
        searchBar.delegate = self
        searchBar.resignWhenKeyboardHides()
        
        navigationItem.titleView = segmentView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.qs_dequeueReusableCell(UITableViewCell.self)
        cell?.textLabel?.text = items[indexPath.row]
        cell?.accessoryType = indexPath.row == selectedIndex ? .checkmark:.none
        cell?.selectionStyle = .none
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    override func registerCellClasses() -> Array<AnyClass> {
        return [UITableViewCell.self]
    }
}

extension HotFilterViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
