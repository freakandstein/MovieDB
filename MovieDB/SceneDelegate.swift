//
//  SceneDelegate.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let splashView = SplashView()
        window?.rootViewController = splashView
        window?.makeKeyAndVisible()

        UITabBar.appearance().backgroundColor = .bg50.withAlphaComponent(.commonAlpha)
        UITabBar.appearance().tintColor = .primary500
    }
}

