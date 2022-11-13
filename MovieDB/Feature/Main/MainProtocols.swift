//
//  MainProtocols.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

protocol MainViewToPresenter {
    var view: MainPresenterToView? { get set }
    var interactor: MainPresenterToInteractor? { get set }
    var router: MainPresenterToRouter? { get set }

}

protocol MainPresenterToView {
    var presenter: MainViewToPresenter? { get set }
}

protocol MainPresenterToInteractor {
    var presenter: MainInteractorToPresenter? { get set }
    var networkService: NetworkService { get set }
    
}

protocol MainPresenterToRouter {
    func createTabBarViews() -> [UIViewController]
}

protocol MainInteractorToPresenter { }
