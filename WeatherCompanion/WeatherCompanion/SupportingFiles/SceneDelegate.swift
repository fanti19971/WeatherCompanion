//
//  SceneDelegate.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let todayWeatherViewController = TodayWeatherViewController()
        let weatherNavigationController = UINavigationController()
        weatherNavigationController.viewControllers = [todayWeatherViewController]
        self.window?.rootViewController = weatherNavigationController
        self.window?.makeKeyAndVisible()
    }

}

