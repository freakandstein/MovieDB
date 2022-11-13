//
//  MovieProtocols.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit

protocol MovieViewToPresenter {
    var view: MoviePresenterToView? { get set }
    var interactor: MoviePresenterToInteractor? { get set }
    var router: MoviePresenterToRouter? { get set }
    
    func viewDidLoad()

}

protocol MoviePresenterToView {
    var presenter: MovieViewToPresenter? { get set }
    
    func setupTableView()
}

protocol MoviePresenterToInteractor {
    var presenter: MovieInteractorToPresenter? { get set }
    var networkService: NetworkService { get set }
    
}

protocol MoviePresenterToRouter { }

protocol MovieInteractorToPresenter { }

