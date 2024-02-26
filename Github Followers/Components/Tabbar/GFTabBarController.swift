//
//  GFTabBarController.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 26/02/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        tabBar.backgroundColor          = .systemGray6
        viewControllers                 = [createSearchNC(), createFavoriteListNC()]
        
    }
    
    func createSearchNC() -> UINavigationController{
        let searchVC = SearchVc()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoriteListNC() -> UINavigationController{
        let favoriteListVC = FavoriteListVC()
        favoriteListVC.title = "Favorite"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteListVC)
    }
}
