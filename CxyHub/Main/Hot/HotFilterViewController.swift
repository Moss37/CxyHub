//
//  HotFilterViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/8.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class HotFilterViewController: BaseTableViewController {
    
    fileprivate var segmentView:UISegmentedControl = UISegmentedControl(frame: .zero)
    fileprivate var searchBar:UISearchBar = UISearchBar(frame: .zero)
    fileprivate var client:HotClient = HotClient()
    fileprivate var items:[String] = []
    fileprivate var adapters:[String:HotFilterAdapter] = [:]
    var selectedLang = HotFilter.shared.lang

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        weak var weakSelf = self
        client.fetchLang { (items) in
            weakSelf?.items = items ?? []
            weakSelf?.createAdapter()
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
        segmentView.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = UIColor.white
        searchBar.delegate = self
        searchBar.resignWhenKeyboardHides()
        
        navigationItem.titleView = segmentView
    }
    
    @objc
    private func segmentAction() {
        
    }
    
    private func createAdapter() {
        let searchAdapter = HotFilterAdapter()
        searchAdapter.headerView = searchBar
        searchAdapter.headerHeight = HotFilterConstants.searchHeaderHeight
        searchAdapter.section = HotFilterConstants.searchSection
        adapters["\(searchAdapter.section)"] = searchAdapter
        
        let currentAdapter = HotFilterAdapter([selectedLang])
        currentAdapter.headerClass = HotFilterHeaderView.self
        currentAdapter.headerHeight = HotFilterConstants.currentHeaderHeight
        currentAdapter.rowHeight = HotFilterConstants.rowHeight
        currentAdapter.section = HotFilterConstants.currentSection
        currentAdapter.headerText = HotFilterConstants.currentHeaderText
        adapters["\(currentAdapter.section)"] = currentAdapter
        
        let normalAdapter = HotFilterAdapter(items)
        normalAdapter.headerHeight = HotFilterConstants.normalHeaderHeight
        normalAdapter.rowHeight = HotFilterConstants.rowHeight
        normalAdapter.section = HotFilterConstants.normalSection
        normalAdapter.selectedLang = selectedLang
        adapters["\(normalAdapter.section)"] = normalAdapter
    }
    
    func updateCurrentAdapter(lang:String) {
        guard let adapter = adapters["\(HotFilterConstants.currentSection)"] else { return }
        adapter.rows = [lang]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return adapters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapters["\(section)"]?.rows.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.qs_dequeueReusableCell(UITableViewCell.self)
        let adapter = adapters["\(indexPath.section)"]
        cell?.textLabel?.text = adapter?.rows[indexPath.row]
        cell?.accessoryType = adapter?.rows[indexPath.row] == adapter?.selectedLang ? .checkmark:.none
        cell?.selectionStyle = .none
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let adapter = adapters["\(section)"]
        return adapter?.headerHeight ?? 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let adapter = adapters["\(section)"] else { return nil }
        if let headerView = adapter.headerView {
            return headerView
        }
        if let cls = adapter.headerClass {
            let headerView = tableView.qs_dequeueReusableHeaderFooterView(cls) as! UITableViewHeaderFooterView
            headerView.textLabel?.text = adapter.headerText
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let adapter = adapters["\(indexPath.section)"] else { return }
        resignSearchBar()
        let lang = adapter.rows[indexPath.row]
        adapter.selectedLang = lang
        updateCurrentAdapter(lang: lang)
        HotFilter.shared.lang = lang
        tableView.reloadData()
    }
    
    override func registerCellClasses() -> Array<AnyClass> {
        return [UITableViewCell.self]
    }
    
    override func registerHeaderViewClasses() -> Array<AnyClass> {
        return [HotFilterHeaderView.self]
    }
    
    fileprivate func resignSearchBar() {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension HotFilterViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignSearchBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let adapter = adapters["\(HotFilterConstants.normalSection)"] else { return }
        if searchText.count == 0 {
            adapter.rows = items
            tableView.reloadData()
            return
        }
        adapter.rows = items.filter { (string) -> Bool in
            return string.contains(searchText)
        }
        tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        resignSearchBar()
    }
}

class HotFilterAdapter: HotFilterAdapterProtocol {
    var section: Int = 0
    
    var rows: [String] = []
    
    var headerHeight: CGFloat = 0.01
    
    var footerHeight: CGFloat = 0.01
    
    var rowHeight: CGFloat = 0.01
    
    weak var headerView:UIView?
    
    var headerClass:UIView.Type?
    
    weak var footerView:UIView?
    
    var accessoryType:UITableViewCell.AccessoryType = .none
    
    var selectedLang:String = ""
    
    var headerText:String = ""
    
    init(_ data:[String] = []) {
        rows = data
    }
    
}

protocol HotFilterAdapterProtocol {
    var section:Int { get set }
    var rows:[String] { get set }
    var headerHeight:CGFloat { get set }
    var footerHeight:CGFloat { get set }
    var rowHeight:CGFloat { get set }
}

struct HotFilterConstants {
    static let searchSection = 0
    static let currentSection = 1
    static let normalSection = 2
    static let searchHeaderHeight:CGFloat = 50
    static let currentHeaderHeight:CGFloat = 40
    static let normalHeaderHeight:CGFloat = 20
    static let rowHeight:CGFloat = 44
    static let currentHeaderText = "Current Language"

}
