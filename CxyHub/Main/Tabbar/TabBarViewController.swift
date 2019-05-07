//
//  TabBarViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }

    private func setupSubviews() {
        let homeItem = UITabBarItem(title: "Trending", image: UIImage(named: "bottom_tabbar_mainhome_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_mainhome_selected")?.withRenderingMode(.alwaysOriginal))
        let channelItem = UITabBarItem(title: "News", image: UIImage(named: "bottom_tabbar_pegasuschannel_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_pegasuschannel_selected")?.withRenderingMode(.alwaysOriginal))
        let dynamicItem = UITabBarItem(title: "Star", image: UIImage(named: "bottom_tabbar_followinghome_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_followinghome_selected")?.withRenderingMode(.alwaysOriginal))
        let vipItem = UITabBarItem(title: "Search", image: UIImage(named: "bottom_tabbar_mallhome_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_mallhome_selected")?.withRenderingMode(.alwaysOriginal))
        let mineItem = UITabBarItem(title: "Mine", image: UIImage(named: "bottom_tabbar_user_center_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_user_center_selected")?.withRenderingMode(.alwaysOriginal))
        
        let homeVC = HotViewController()
        homeVC.tabBarItem = homeItem
        
        let channelVC = NewsViewController()
        channelVC.tabBarItem = channelItem
        
        let dynamicVC = StarViewController()
        dynamicVC.tabBarItem = dynamicItem
        
        let vipVC = SearchViewController()
        vipVC.tabBarItem = vipItem
        
        let mineVC = MineViewController()
        mineVC.tabBarItem = mineItem
        
        viewControllers = [homeVC, channelVC, dynamicVC, vipVC, mineVC]
        for (_, item) in tabBar.items!.enumerated() {
            let normalAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.0)]
            let selectedAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0.98, green: 0.45, blue: 0.60, alpha: 1.0)]
            item.setTitleTextAttributes(normalAttributes, for: .normal)
            item.setTitleTextAttributes(selectedAttributes, for: .selected)
        }
    }
}
