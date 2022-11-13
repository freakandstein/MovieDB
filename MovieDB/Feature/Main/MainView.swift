//
//  MainView.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

class MainView: UITabBarController, UINavigationControllerDelegate {
    
    //MARK: Properties
    private let bundle = Bundle(for: MainView.self)
    private let className = String(describing: MainView.self)
    
    var presenter: MainViewToPresenter?
    
    //MARK: IBoutlets
    
    //MARK: Functions
    init() {
        super.init(nibName: className, bundle: bundle)
        let view = self
        let presenter = MainPresenter()
        let router = MainRouter()
        view.viewControllers = router.createTabBarViews()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView: MainPresenterToView { }
