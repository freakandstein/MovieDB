//
//  SplashPresenter.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

class SplashPresenter: SplashViewToPresenter {
    
    var view: SplashPresenterToView?
    var interactor: SplashPresenterToInteractor?
    var router: SplashPresenterToRouter?
    
    func viewDidLoad() {
        view?.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view?.hideLoading()
            self.router?.navigateToMain()
        }
    }
}
