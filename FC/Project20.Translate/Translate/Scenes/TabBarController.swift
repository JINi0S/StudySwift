//
//  TabBarController.swift
//  Translate
//
//  Created by 이진희 on 2022/09/30.
//

import UIKit

final class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateViewController = TranslateViewController()
        translateViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Translate", comment: "번역"),
            image: UIImage(systemName: "mic"),
            selectedImage: UIImage(systemName: "mic.fill")
        )
        
        let bookmarkViewController = UINavigationController(rootViewController: BookmarkListViewController())
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Bookmark", comment: "북마크"),
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
    
        viewControllers = [translateViewController, bookmarkViewController]
    }
    
    
    
}

