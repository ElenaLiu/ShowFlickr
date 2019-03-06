//
//  TabBarController.swift
//  AjHW
//
//  Created by 劉芳瑜 on 2019/3/6.
//  Copyright © 2019 Fang-Yu. Liu. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    init(text: String, perPage: Int) {
        super.init(nibName: nil, bundle: nil)
        let firstController = ShowInfoController(text: text, perPage: perPage)
        firstController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let secondController = FavoriteController()
        secondController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        viewControllers = [firstController, secondController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
