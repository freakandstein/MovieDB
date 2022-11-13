//
//  MovieInteractor.swift
//  MovieDB
//
//  Created by Satrio Wicaksono on 13/11/22.
//

import Foundation

class MovieInteractor: MoviePresenterToInteractor {
    var presenter: MovieInteractorToPresenter?
    var networkService: NetworkService = NetworkService.shared
    
    func callGetMovieUpcoming(page: Int) {
        let target = MainService.getUpcomingMovie(page: page)
        networkService.request(target: target, model: MovieModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieModel):
                self.presenter?.didGetMovieUpcoming(model: movieModel, error: nil)
            case .failure(let error as ErrorModel):
                self.presenter?.didGetMovieUpcoming(model: nil, error: error)
            default:
                break
            }
        }
    }
    
    func callGetMovieNowPlaying(page: Int) {
        let target = MainService.getNowPlayingMovie(page: page)
        networkService.request(target: target, model: MovieModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieModel):
                self.presenter?.didGetMovieNowPlaying(model: movieModel, error: nil)
            case .failure(let error as ErrorModel):
                self.presenter?.didGetMovieNowPlaying(model: nil, error: error)
            default:
                break
            }
        }
    }
    
    func callGetMoviePopular(page: Int) {
        let target = MainService.getPopularMovie(page: page)
        networkService.request(target: target, model: MovieModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieModel):
                self.presenter?.didGetMoviePopular(model: movieModel, error: nil)
            case .failure(let error as ErrorModel):
                self.presenter?.didGetMoviePopular(model: nil, error: error)
            default:
                break
            }
        }
    }
    
    func callGetMovieTopRated(page: Int) {
        let target = MainService.getTopRatedMovie(page: page)
        networkService.request(target: target, model: MovieModel.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movieModel):
                self.presenter?.didGetMovieTopRated(model: movieModel, error: nil)
            case .failure(let error as ErrorModel):
                self.presenter?.didGetMovieTopRated(model: nil, error: error)
            default:
                break
            }
        }
    }
}
