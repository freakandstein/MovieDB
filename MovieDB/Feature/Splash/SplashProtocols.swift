//
//  SplashProtocols.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

protocol SplashViewToPresenter {
    var view: SplashPresenterToView? { get set }
    var interactor: SplashPresenterToInteractor? { get set }
    
    func viewDidLoad()

}

protocol SplashPresenterToView {
    var presenter: SplashViewToPresenter? { get set }

    func showLoading()
    func hideLoading()
}

protocol SplashPresenterToInteractor {
    var presenter: SplashInteractorToPresenter? { get set }
//    var networkService: NetworkService { get set }
//    var dataService: DataServiceProtocol { get set }
    
//    func getCurrencyIndex()
//    func getCurrentLocation()
//    func getDailyCurrencyIndex()
}

protocol SplashInteractorToPresenter {
//    var currentPrice: CurrentPriceResponse? { get set }
//    var listPriceIndex: [PriceIndex] { get set }
    
//    func didGetCurrencyIndexSuccess(response: CurrentPriceResponse)
//    func didGetCurrencyIndexFailure(error: ErrorResponse)
}
