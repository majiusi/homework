//
//  SceneDelegate.swift
//  Homework6
//
//  Created by Margis on 2019/12/01.
//  Copyright © 2019 Margis. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let calendarController = CalendarController()
        let navigationController = UINavigationController(rootViewController: calendarController)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

