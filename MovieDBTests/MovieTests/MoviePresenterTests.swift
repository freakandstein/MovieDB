//
//  MoviePresenterTests.swift
//  MovieDBTests
//
//  Created by Satrio Wicaksono on 16/11/22.
//

import XCTest
@testable import MovieDB

final class MoviePresenterTests: XCTestCase {
    
    //View Mock
    class MovieViewMock: MoviePresenterToView {
        var presenter: MovieViewToPresenter?
        
        var isLoadMoreCalled: Bool = false
        func load(by mainTableViewIndex: MainTableViewIndex) {
            isLoadMoreCalled = true
        }
        
        var isReloadCalled: Bool = false
        func reload() {
            isReloadCalled = true
        }
        
        var isSetupTableViewCalled: Bool = false
        func setupTableView() {
            isSetupTableViewCalled = true
        }
        
        var isLoadFailedCalled: Bool = false
        func loadFailed(by mainTableViewIndex: MovieDB.MainTableViewIndex, error: MovieDB.ErrorModel) {
            isLoadMoreCalled = true
        }
    }
    
    // Interactor Mock
    class MovieInteractorMock: MoviePresenterToInteractor {
        var presenter: MovieInteractorToPresenter?
        var dataService: DataServiceProtocol = DataService.shared
        var networkMonitoringService: NetworkMonitorServiceProtocol = NetworkMonitorService.shared
        var networkService: NetworkService = NetworkService()
        
        var isCallGetMovieNowPlayingCalled: Bool = false
        func callGetMovieNowPlaying(page: Int) {
            isCallGetMovieNowPlayingCalled = true
        }
        
        var isCallGetMoviePopularCalled: Bool = false
        func callGetMoviePopular(page: Int) {
            isCallGetMoviePopularCalled = true
        }
        
        var isCallGetMovieTopRatedCalled: Bool = false
        func callGetMovieTopRated(page: Int) {
            isCallGetMovieTopRatedCalled = true
        }
        
        var isCallGetMovieUpcomingCalled: Bool = false
        func callGetMovieUpcoming(page: Int) {
            isCallGetMovieUpcomingCalled = true
        }
        
        var isIsNetworkOnlineCalled: Bool = false
        func isNetworkOnline() -> Bool {
            isIsNetworkOnlineCalled = true
            return networkMonitoringService.isOnline
        }
        
        var isLoadMovieModelCalled: Bool = false
        func loadMovieModel(section: MainTableViewIndex) -> MovieModel? {
            isLoadMovieModelCalled = true
            return nil
        }
        
        var isSaveMovieNowPlayingCalled: Bool = false
        func saveMovieNowPlaying(model: MovieModel?) -> Bool {
            isSaveMovieNowPlayingCalled = true
            return true
        }
        
        var isSaveMoviePopularCalled: Bool = false
        func saveMoviePopular(model: MovieModel?) -> Bool {
            isSaveMoviePopularCalled = true
            return true
        }
        
        var isSaveMovieTopRatedCalled: Bool = false
        func saveMovieTopRated(model: MovieModel?) -> Bool {
            isSaveMovieTopRatedCalled = true
            return true
        }
        
        var isSaveMovieUpcomingCalled: Bool = false
        func saveMovieUpcoming(model: MovieModel?) -> Bool {
            isSaveMovieUpcomingCalled = true
            return true
        }
    }
    
    // Network Monitor Service Mock
    class NetworkMonitorServiceMock: NetworkMonitorServiceProtocol {
        var isOnline: Bool = false
        
        func monitorNetwork() {
            isOnline = false
        }
    }
    
    // Router Mock
    class MovieRouterMock: MoviePresenterToRouter {
        var isNavigateToMovieDetailCalled = false
        func navigateToMovieDetail(model: MovieDetailModel, view: MoviePresenterToView) {
            isNavigateToMovieDetailCalled = true
        }
    }
    
    var sut: MoviePresenter = MoviePresenter()
    var view: MovieViewMock = MovieViewMock()
    var interactor: MovieInteractorMock = MovieInteractorMock()
    var router: MovieRouterMock = MovieRouterMock()
    var networkMonitorServiceMock = NetworkMonitorServiceMock()

    func testViewDidLoadWithNetworkOn() throws {
        networkMonitorServiceMock.isOnline = true
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        
        sut.viewDidLoad()
        
        XCTAssertTrue(view.isSetupTableViewCalled)
        XCTAssertTrue(interactor.isIsNetworkOnlineCalled)
        XCTAssertTrue(interactor.isCallGetMovieUpcomingCalled)
        XCTAssertTrue(interactor.isCallGetMoviePopularCalled)
        XCTAssertTrue(interactor.isCallGetMovieTopRatedCalled)
        XCTAssertTrue(interactor.isCallGetMovieNowPlayingCalled)
    }
    
    func testViewDidLoadWithNetworkOff() throws {
        networkMonitorServiceMock.isOnline = false
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        
        sut.viewDidLoad()
        
        XCTAssertTrue(view.isSetupTableViewCalled)
        XCTAssertTrue(interactor.isLoadMovieModelCalled)
        XCTAssertTrue(view.isReloadCalled)
    }
    
    func testLoadmore() throws {
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        
        sut.loadmore(section: .nowPlaying, currentPage: 1)
        sut.loadmore(section: .topRated, currentPage: 1)
        sut.loadmore(section: .popular, currentPage: 1)
        sut.loadmore(section: .upcoming, currentPage: 1)
        
        XCTAssertTrue(interactor.isCallGetMovieTopRatedCalled)
        XCTAssertTrue(interactor.isCallGetMovieNowPlayingCalled)
        XCTAssertTrue(interactor.isCallGetMovieUpcomingCalled)
        XCTAssertTrue(interactor.isCallGetMoviePopularCalled)
    }
    
    func testNavigateToMovieDetail() throws {
        let movieDetail: MovieDetailModel = MovieDetailModel(id: 1, overview: .empty, title: .empty, posterPath: .empty, backdropPath: .empty, releaseDate: .empty)
        
        let movie: MovieModel = MovieModel(page: 1, results: [movieDetail], totalPages: 1, totalResults: 1)
        sut.topRatedMovie = movie
        sut.nowPlayingMovie = movie
        sut.upcomingMovie = movie
        sut.popularMovie = movie
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        sut.router = router
        
        sut.navigateToMovieDetail(section: .nowPlaying, row: 0)
        sut.navigateToMovieDetail(section: .topRated, row: 0)
        sut.navigateToMovieDetail(section: .popular, row: 0)
        sut.navigateToMovieDetail(section: .upcoming, row: 0)
        
        XCTAssertTrue(router.isNavigateToMovieDetailCalled)
    }
    
    func testDidGetMovieUpcoming() {
        let movieDetail: MovieDetailModel = MovieDetailModel(id: 1, overview: .empty, title: .empty, posterPath: .empty, backdropPath: .empty, releaseDate: .empty)
        
        let movie: MovieModel = MovieModel(page: 1, results: [movieDetail], totalPages: 1, totalResults: 1)
        
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        
        sut.upcomingMovie = movie
        sut.didGetMovieUpcoming(model: movie, error: nil)
        XCTAssertTrue(view.isLoadMoreCalled)
        
        sut.didGetMovieUpcoming(model: nil, error: ErrorModel(statusCode: 404, statusMessage: "There is something error!"))
        
        XCTAssertTrue(interactor.isSaveMovieUpcomingCalled)
    }
    
    func testDidGetMovieTopRated() {
        let movieDetail: MovieDetailModel = MovieDetailModel(id: 1, overview: .empty, title: .empty, posterPath: .empty, backdropPath: .empty, releaseDate: .empty)
        
        let movie: MovieModel = MovieModel(page: 1, results: [movieDetail], totalPages: 1, totalResults: 1)
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        
        sut.topRatedMovie = movie
        sut.didGetMovieTopRated(model: movie, error: nil)
        XCTAssertTrue(view.isLoadMoreCalled)
        
        sut.didGetMovieTopRated(model: nil, error: ErrorModel(statusCode: 404, statusMessage: "There is something error!"))
        
        XCTAssertTrue(interactor.isSaveMovieTopRatedCalled)
    }
    
    func testDidGetMovieNowPlaying() {
        let movieDetail: MovieDetailModel = MovieDetailModel(id: 1, overview: .empty, title: .empty, posterPath: .empty, backdropPath: .empty, releaseDate: .empty)
        
        let movie: MovieModel = MovieModel(page: 1, results: [movieDetail], totalPages: 1, totalResults: 1)
        
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        
        sut.nowPlayingMovie = movie
        sut.didGetMovieNowPlaying(model: movie, error: nil)
        XCTAssertTrue(view.isLoadMoreCalled)
        
        sut.didGetMovieNowPlaying(model: nil, error: ErrorModel(statusCode: 404, statusMessage: "There is something error!"))
        
        XCTAssertTrue(interactor.isSaveMovieNowPlayingCalled)
    }
    
    func testDidGetMoviePopular() {
        let movieDetail: MovieDetailModel = MovieDetailModel(id: 1, overview: .empty, title: .empty, posterPath: .empty, backdropPath: .empty, releaseDate: .empty)
        
        let movie: MovieModel = MovieModel(page: 1, results: [movieDetail], totalPages: 1, totalResults: 1)
        
        interactor.networkMonitoringService = networkMonitorServiceMock
        sut.view = view
        sut.interactor = interactor
        
        sut.popularMovie = movie
        sut.didGetMoviePopular(model: movie, error: nil)
        XCTAssertTrue(view.isLoadMoreCalled)
        
        sut.didGetMoviePopular(model: nil, error: ErrorModel(statusCode: 404, statusMessage: "There is something error!"))
        
        XCTAssertTrue(interactor.isSaveMoviePopularCalled)
    }
}
