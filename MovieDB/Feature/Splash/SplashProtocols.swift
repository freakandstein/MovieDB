//
//  SplashProtocols.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation
import UIKit

protocol SplashViewToPresenter {
    var view: SplashPresenterToView? { get set }
    var interactor: SplashPresenterToInteractor? { get set }
    var router: SplashPresenterToRouter? { get set }
    
    func viewDidLoad()

}

protocol SplashPresenterToView {
    var presenter: SplashViewToPresenter? { get set }

    func showLoading()
    func hideLoading()
}

protocol SplashPresenterToInteractor {
    var presenter: SplashInteractorToPresenter? { get set }
    var networkService: NetworkService { get set }
    
}

protocol SplashPresenterToRouter {
    var window: UIWindow? { get }
    
    func navigateToMain()
}

protocol SplashInteractorToPresenter {

}
