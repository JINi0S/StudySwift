//
//  TabBarViewController.swift
//  AppStore
//
//  Created by 이진희 on 2022/08/08.
//

import UIKit

class TabBarController: UITabBarController {

    private lazy var todayViewController: UIViewController = {
        let viewController = TodayViewContoller()
        let tabBarItem = UITabBarItem(title: "투데이", image: UIImage(systemName: "mail"), tag: 0)
        viewController.tabBarItem = tabBarItem
        
        return viewController
    }()
    
    private lazy var appViewConroller: UIViewController = {
        let viewController = UINavigationController(rootViewController: AppViewController())
        let tabBarItem = UITabBarItem(title: "앱", image: UIImage(systemName: "square.stack.3d.up"), tag: 1)
        viewController.tabBarItem = tabBarItem
        return viewController
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [todayViewController, appViewConroller]
    }


}

