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
    var upcomingMovie: MovieModel? { get set }
    var topRatedMovie: MovieModel? { get set }
    var nowPlayingMovie: MovieModel? { get set }
    var popularMovie: MovieModel? { get set }
    
    func viewDidLoad()
    func loadmore(section: MainTableViewIndex, currentPage: Int)

}

protocol MoviePresenterToView {
    var presenter: MovieViewToPresenter? { get set }
    
    func setupTableView()
    func reloadSection(_ section: MainTableViewIndex)
}

protocol MoviePresenterToInteractor {
    var presenter: MovieInteractorToPresenter? { get set }
    var networkService: NetworkService { get set }
    
    func callGetMovieTopRated(page: Int)
    func callGetMoviePopular(page: Int)
    func callGetMovieUpcoming(page: Int)
    func callGetMovieNowPlaying(page: Int)
}

protocol MoviePresenterToRouter { }

protocol MovieInteractorToPresenter {
    
    func didGetMovieTopRated(model: MovieModel?, error: ErrorModel?)
    func didGetMovieUpcoming(model: MovieModel?, error: ErrorModel?)
    func didGetMovieNowPlaying(model: MovieModel?, error: ErrorModel?)
    func didGetMoviePopular(model: MovieModel?, error: ErrorModel?)
}

