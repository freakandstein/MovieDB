//
//  MovieProtocols.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation
import UIKit

protocol MovieViewToPresenter: AnyObject {
    var view: MoviePresenterToView? { get set }
    var interactor: MoviePresenterToInteractor? { get set }
    var router: MoviePresenterToRouter? { get set }
    var upcomingMovie: MovieModel? { get set }
    var topRatedMovie: MovieModel? { get set }
    var nowPlayingMovie: MovieModel? { get set }
    var popularMovie: MovieModel? { get set }
    
    func viewDidLoad()
    func loadmore(section: MainTableViewIndex, currentPage: Int)
    func navigateToMovieDetail(section: MainTableViewIndex, row: Int)

}

protocol MoviePresenterToView: AnyObject {
    var presenter: MovieViewToPresenter? { get set }
    
    func setupTableView()
    func reloadSection(_ section: MainTableViewIndex)
    func reload()
    func loadMore(by mainTableViewIndex: MainTableViewIndex)
    func loadFailed(by mainTableViewIndex: MainTableViewIndex, error: ErrorModel)
}

protocol MoviePresenterToInteractor: AnyObject {
    var presenter: MovieInteractorToPresenter? { get set }
    var networkService: NetworkService { get set }
    var dataService: DataServiceProtocol { get set }
    var networkMonitoringService: NetworkMonitorServiceProtocol { get set }
    
    func callGetMovieTopRated(page: Int)
    func callGetMoviePopular(page: Int)
    func callGetMovieUpcoming(page: Int)
    func callGetMovieNowPlaying(page: Int)
    func saveMovieTopRated(model: MovieModel?) -> Bool
    func saveMoviePopular(model: MovieModel?) -> Bool
    func saveMovieUpcoming(model: MovieModel?) -> Bool
    func saveMovieNowPlaying(model: MovieModel?) -> Bool
    func isNetworkOnline() -> Bool
    func loadMovieModel(section: MainTableViewIndex) -> MovieModel?
}

protocol MoviePresenterToRouter: AnyObject {
    func navigateToMovieDetail(model: MovieDetailModel, view: MoviePresenterToView)
}

protocol MovieInteractorToPresenter: AnyObject {
    
    func didGetMovieTopRated(model: MovieModel?, error: ErrorModel?)
    func didGetMovieUpcoming(model: MovieModel?, error: ErrorModel?)
    func didGetMovieNowPlaying(model: MovieModel?, error: ErrorModel?)
    func didGetMoviePopular(model: MovieModel?, error: ErrorModel?)
}

