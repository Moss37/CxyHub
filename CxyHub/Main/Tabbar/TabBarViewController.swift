//
//  TabBarViewController.swift
//  CxyHub
//
//  Created by caony on 2019/5/6.
//  Copyright © 2019年 cj. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var lastSelectedIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self

        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    private func setupSubviews() {
        let homeItem = UITabBarItem(title: "Trending", image: UIImage(named: "bottom_tabbar_mainhome_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_mainhome_selected")?.withRenderingMode(.alwaysOriginal))
        let channelItem = UITabBarItem(title: "News", image: UIImage(named: "bottom_tabbar_pegasuschannel_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_pegasuschannel_selected")?.withRenderingMode(.alwaysOriginal))
        let dynamicItem = UITabBarItem(title: "Star", image: UIImage(named: "bottom_tabbar_followinghome_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_followinghome_selected")?.withRenderingMode(.alwaysOriginal))
        let vipItem = UITabBarItem(title: "Search", image: UIImage(named: "bottom_tabbar_mallhome_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_mallhome_selected")?.withRenderingMode(.alwaysOriginal))
        let mineItem = UITabBarItem(title: "Mine", image: UIImage(named: "bottom_tabbar_user_center_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "bottom_tabbar_user_center_selected")?.withRenderingMode(.alwaysOriginal))
        
        let homeVC = HotViewController()
        let homeNav = BaseNavigationViewController(rootViewController: homeVC)
        homeNav.tabBarItem = homeItem
        
        let channelVC = NewsViewController()
        let channelNav = BaseNavigationViewController(rootViewController: channelVC)
        channelNav.tabBarItem = channelItem
        
        let dynamicVC = StarViewController()
        let dynamicNav = BaseNavigationViewController(rootViewController: dynamicVC)
        dynamicNav.tabBarItem = dynamicItem
        
        let vipVC = SearchViewController()
        let vipNav = BaseNavigationViewController(rootViewController: vipVC)
        vipNav.tabBarItem = vipItem
        
        let mineVC = MineViewController()
        let mineNav = BaseNavigationViewController(rootViewController: mineVC)
        mineNav.tabBarItem = mineItem
        
        viewControllers = [homeNav, channelNav, dynamicNav, vipNav, mineNav]
        for (_, item) in tabBar.items!.enumerated() {
            let normalAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0.48, green: 0.48, blue: 0.48, alpha: 1.0)]
            let selectedAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0.98, green: 0.45, blue: 0.60, alpha: 1.0)]
            item.setTitleTextAttributes(normalAttributes, for: .normal)
            item.setTitleTextAttributes(selectedAttributes, for: .selected)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let baseNav = viewController as? BaseNavigationViewController else {
            return
        }
        guard let baseVC = baseNav.topViewController as? BaseViewController else {
            return
        }
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        lastSelectedIndex = selectedIndex
        if let index = tabBar.items?.index(of: item) {
            guard let navController = viewControllers?[index] as? BaseNavigationViewController else {
                return
            }
            guard let viewController = navController.topViewController as? BaseViewController else {
                return
            }
            if viewController.needsLogin {
                
            }
        }
    }
}
