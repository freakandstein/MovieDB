//
//  MoviePresenter.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation

class MoviePresenter: MovieViewToPresenter {
    var view: MoviePresenterToView?
    var interactor: MoviePresenterToInteractor?
    var router: MoviePresenterToRouter?
    
    func viewDidLoad() {
        view?.setupTableView()
    }
}

extension MoviePresenter: MovieInteractorToPresenter { }
