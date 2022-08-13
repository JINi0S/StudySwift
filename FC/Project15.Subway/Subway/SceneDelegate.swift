//
//  SceneDelegate.swift
//  Subway
//
//  Created by 이진희 on 2022/08/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController =  UINavigationController(rootViewController: StationSearchViewController())
    
        window?.makeKeyAndVisible()
    }

    

}

