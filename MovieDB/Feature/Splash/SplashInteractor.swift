//
//  SplashInteractor.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

class SplashInteractor: SplashPresenterToInteractor {
    var networkService: NetworkService = NetworkService.shared
    var presenter: SplashInteractorToPresenter?
}
