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
    var dataService: DataServiceProtocol = DataService.shared
    var networkMonitoringService: NetworkMonitorServiceProtocol = NetworkMonitorService.shared
    
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
    
    func saveMovieNowPlaying(model: MovieModel?) -> Bool {
        if let model = model {
            let result = try? self.dataService.save(data: model, key: MovieModelKey.nowPlaying.value)
            return result ?? false
        }
        return false
    }
    
    func saveMoviePopular(model: MovieModel?) -> Bool {
        if let model = model {
            let result = try? self.dataService.save(data: model, key: MovieModelKey.popular.value)
            return result ?? false
        }
        return false
    }
    
    func saveMovieTopRated(model: MovieModel?) -> Bool {
        if let model = model {
            let result = try? self.dataService.save(data: model, key: MovieModelKey.topRated.value)
            return result ?? false
        }
        return false
    }
    
    func saveMovieUpcoming(model: MovieModel?) -> Bool {
        if let model = model {
            let result = try? self.dataService.save(data: model, key: MovieModelKey.upcoming.value)
            return result ?? false
        }
        return false
    }
    
    func loadMovieModel(section: MainTableViewIndex) -> MovieModel? {
        var model: MovieModel?
        var data: Data?
        switch section {
        case .topRated:
            data = (try? dataService.load(key: MovieModelKey.topRated.value)) ?? Data()
        case .popular:
            data = try? dataService.load(key: MovieModelKey.popular.value)
        case .upcoming:
            data = try? dataService.load(key: MovieModelKey.upcoming.value)
        case .nowPlaying:
            data = try? dataService.load(key: MovieModelKey.nowPlaying.value)
        }
        if let data = data {
            model = try? JSONDecoder().decode(MovieModel.self, from: data)
        }
        return model
    }
    
    func isNetworkOnline() -> Bool {
        return networkMonitoringService.isOnline
    }
}
