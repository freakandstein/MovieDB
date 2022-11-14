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
        interactor?.callGetMovieUpcoming(page: 1)
        interactor?.callGetMoviePopular(page: 1)
        interactor?.callGetMovieTopRated(page: 1)
        interactor?.callGetMovieNowPlaying(page: 1)
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
}

extension MoviePresenter: MovieInteractorToPresenter {
    func didGetMovieUpcoming(model: MovieModel?, error: ErrorModel?) {
        if let error = error {
            print(error)
        } else {
            if upcomingMovie == nil {
                upcomingMovie = model
            } else {
                upcomingMovie?.page = model?.page ?? .zero
                upcomingMovie?.results.append(contentsOf: (model?.results ?? []))
            }
            _ = interactor?.saveMovieUpcoming(model: upcomingMovie)
            view?.reloadSection(.upcoming)
        }
    }
    
    func didGetMovieTopRated(model: MovieModel?, error: ErrorModel?) {
        if let error = error {
            print(error)
        } else {
            if topRatedMovie == nil {
                topRatedMovie = model
            } else {
                topRatedMovie?.page = model?.page ?? .zero
                topRatedMovie?.results.append(contentsOf: (model?.results ?? []))
            }
            _ = interactor?.saveMovieUpcoming(model: topRatedMovie)
            view?.reloadSection(.topRated)
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
            _ = interactor?.saveMovieUpcoming(model: nowPlayingMovie)
            view?.reloadSection(.nowPlaying)
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
            _ = interactor?.saveMovieUpcoming(model: upcomingMovie)
            view?.reloadSection(.popular)
        }
    }
}
