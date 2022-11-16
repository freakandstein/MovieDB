//
//  MainProtocols.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

protocol MainViewToPresenter: AnyObject {
    var view: MainPresenterToView? { get set }
    var interactor: MainPresenterToInteractor? { get set }
    var router: MainPresenterToRouter? { get set }
}

protocol MainPresenterToView: AnyObject {
    var presenter: MainViewToPresenter? { get set }
}

protocol MainPresenterToInteractor: AnyObject {
    var presenter: MainInteractorToPresenter? { get set }
    var networkService: NetworkService { get set }
}

protocol MainPresenterToRouter: AnyObject {
    func createTabBarViews() -> [UIViewController]
}

protocol MainInteractorToPresenter: AnyObject { }
