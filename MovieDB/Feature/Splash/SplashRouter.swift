//
//  SplashRouter.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

class SplashRouter: SplashPresenterToRouter {
    
    internal var window: UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first
        }
        return nil
    }
    
    func navigateToMain() {
        let mainView = MainView()
        window?.rootViewController = mainView
    }
}
