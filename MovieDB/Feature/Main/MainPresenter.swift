//
//  MainPresenter.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 12/11/22.
//

import Foundation

class MainPresenter: MainViewToPresenter {
    var view: MainPresenterToView?
    var interactor: MainPresenterToInteractor?
    var router: MainPresenterToRouter?
    
    func viewDidLoad() {
        
    }
    
    
}

extension MainPresenter: MainInteractorToPresenter {
    
}
