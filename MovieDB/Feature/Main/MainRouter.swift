//
//  MainRouter.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

class MainRouter: MainPresenterToRouter {
    
    func createTabBarViews() -> [UIViewController] {
        let movieView = MovieView()
        let navigationMoviewView = UINavigationController(rootViewController: movieView)
        navigationMoviewView.tabBarItem.image = .movieIcon
        navigationMoviewView.tabBarItem.title = "Movie"
        navigationMoviewView.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: .zero, vertical: 16)
        navigationMoviewView.tabBarItem.imageInsets = UIEdgeInsets(top: 16, left: .zero, bottom: -8, right: .zero)
        
        return [navigationMoviewView]
    }
}
