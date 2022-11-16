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
    var upcomingMovie: MovieModel?
    var nowPlayingMovie: MovieModel?
    var popularMovie: MovieModel?
    var topRatedMovie: MovieModel?
    
    func viewDidLoad() {
        view?.setupTableView()
        if interactor?.isNetworkOnline() ?? false {
            interactor?.callGetMovieUpcoming(page: 1)
            interactor?.callGetMoviePopular(page: 1)
            interactor?.callGetMovieTopRated(page: 1)
            interactor?.callGetMovieNowPlaying(page: 1)
        } else {
            upcomingMovie = interactor?.loadMovieModel(section: .upcoming)
            nowPlayingMovie = interactor?.loadMovieModel(section: .nowPlaying)
            popularMovie = interactor?.loadMovieModel(section: .popular)
            topRatedMovie = interactor?.loadMovieModel(section: .topRated)
            view?.reload()
        }
    }
    
    func loadmore(section: MainTableViewIndex, currentPage: Int) {
        let nextPage = currentPage + 1
        switch section {
        case .topRated:
            interactor?.callGetMovieTopRated(page: nextPage)
        case .nowPlaying:
            interactor?.callGetMovieNowPlaying(page: nextPage)
        case .upcoming:
            interactor?.callGetMovieUpcoming(page: nextPage)
        case .popular:
            interactor?.callGetMoviePopular(page: nextPage)
        }
    }
    
    func navigateToMovieDetail(section: MainTableViewIndex, row: Int) {
        var data: MovieDetailModel?
        switch section {
        case .topRated:
            data = topRatedMovie?.results[row]
        case .nowPlaying:
            data = nowPlayingMovie?.results[row]
        case .upcoming:
            data = upcomingMovie?.results[row]
        case .popular:
            data = popularMovie?.results[row]
        }
        if let data = data, let view = view {
            router?.navigateToMovieDetail(model: data, view: view)
        }
    }
}

extension MoviePresenter: MovieInteractorToPresenter {
    func didGetMovieUpcoming(model: MovieModel?, error: ErrorModel?) {
        if let error = error {
            view?.loadFailed(by: .upcoming, error: error)
        } else {
            if upcomingMovie == nil {
                upcomingMovie = model
            } else {
                upcomingMovie?.page = model?.page ?? .zero
                upcomingMovie?.results.append(contentsOf: (model?.results ?? []))
            }
            view?.load(by: .upcoming)
            _ = interactor?.saveMovieUpcoming(model: upcomingMovie)
        }
    }
    
    func didGetMovieTopRated(model: MovieModel?, error: ErrorModel?) {
        if let error = error {
            view?.loadFailed(by: .topRated, error: error)
        } else {
            if topRatedMovie == nil {
                topRatedMovie = model
            } else {
                topRatedMovie?.page = model?.page ?? .zero
                topRatedMovie?.results.append(contentsOf: (model?.results ?? []))
            }
            view?.load(by: .topRated)
            _ = interactor?.saveMovieTopRated(model: topRatedMovie)
        }
    }
    
    func didGetMovieNowPlaying(model: MovieModel?, error: ErrorModel?) {
        if let error = error {
            print(error)
        } else {
            if nowPlayingMovie == nil {
                nowPlayingMovie = model
            } else {
                nowPlayingMovie?.page = model?.page ?? .zero
                nowPlayingMovie?.results.append(contentsOf: (model?.results ?? []))
            }
            view?.load(by: .nowPlaying)
            _ = interactor?.saveMovieNowPlaying(model: nowPlayingMovie)
        }
    }
    
    func didGetMoviePopular(model: MovieModel?, error: ErrorModel?) {
        if let error = error {
            print(error)
        } else {
            if popularMovie == nil {
                popularMovie = model
            } else {
                popularMovie?.page = model?.page ?? .zero
                popularMovie?.results.append(contentsOf: (model?.results ?? []))
            }
            view?.load(by: .popular)
            _ = interactor?.saveMoviePopular(model: popularMovie)
        }
    }
}
