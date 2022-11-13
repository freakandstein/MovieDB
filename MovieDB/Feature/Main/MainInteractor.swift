//
//  MainInteractor.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

class MainInteractor: MainPresenterToInteractor {
    var presenter: MainInteractorToPresenter?
    var networkService: NetworkService = NetworkService.shared
    
    
}
