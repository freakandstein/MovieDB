//
//  MovieInteractorTests.swift
//  MovieDBTests
//
//  Created by Satrio Wicaksono on 16/11/22.
//

import XCTest
import Moya
@testable import MovieDB

final class MovieInteractorTests: XCTestCase {

    // Network Service Mock
    class NetworkServiceMock: NetworkServiceProtocol {
        var isRequestCalled: Bool = false
        var isFlagError: Bool = false
        func request<T, M>(target: T, model: M.Type, completion: @escaping (Result<M, Error>) -> Void) where T : TargetType, M : Decodable {
            isRequestCalled = true
            if !isFlagError {
                completion(.success(MovieInteractorTests.generateMockModel() as! M))
            } else {
                completion(.failure(ErrorModel(statusCode: 402, statusMessage: "There is something error!")))
            }
        }
    }
    
    // Presenter Mock
    class MoviePresenterMock: MovieInteractorToPresenter {
        var isDidGetMovieUpcomingCalled: Bool = false
        func didGetMovieUpcoming(model: MovieModel?, error: ErrorModel?) {
            isDidGetMovieUpcomingCalled = true
        }

        var isDidGetMovieNowPlayingCalled: Bool = false
        func didGetMovieNowPlaying(model: MovieModel?, error: ErrorModel?) {
            isDidGetMovieNowPlayingCalled = true
        }

        var isDidGetMoviePopularCalled: Bool = false
        func didGetMoviePopular(model: MovieModel?, error: ErrorModel?) {
        isDidGetMoviePopularCalled = true
        }
        
        var isDidGetMovieTopRatedCalled: Bool = false
        func didGetMovieTopRated(model: MovieModel?, error: ErrorModel?) {
            isDidGetMovieTopRatedCalled = true
        }
    }
    
    // Data Service Mock
    class DataServiceMock: DataServiceProtocol {
        
        var isSaveCalled: Bool = false
        func save<T>(data: T, key: String) throws -> Bool where T : Decodable, T : Encodable {
            isSaveCalled = true
            return true
        }
        
        var isLoadCalled: Bool = false
        func load(key: String) throws -> Data {
            isLoadCalled = true
            return Data()
        }
        
        var isRemoveCalled: Bool = false
        func remove(key: String) throws {
            isRemoveCalled = true
        }
    }
    
    // Network Monitor Service Mock
    class NetworkMonitorServiceMock: NetworkMonitorServiceProtocol {
        var isOnline: Bool = true
        
        var isMonitoringNetworkCalled: Bool = false
        func monitorNetwork() {
            isMonitoringNetworkCalled = true
        }
    }
    
    var sut: MovieInteractor = MovieInteractor()
    var networkServiceProviderMock = NetworkServiceMock()
    var presenter: MoviePresenterMock = MoviePresenterMock()
    var dataService: DataServiceMock = DataServiceMock()
    var networkMonitoringService: NetworkMonitorServiceMock = NetworkMonitorServiceMock()

    func testCallGetMovieUpcomingSuccess() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMovieUpcoming(page: 1)
        
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMovieUpcomingCalled)
    }
    
    func testCallGetMovieUpcomingFailure() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        networkServiceProviderMock.isFlagError = true
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMovieUpcoming(page: 1)
        
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMovieUpcomingCalled)
    }
    
    func testCallGetMovieNowPlayingSuccess() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMovieNowPlaying(page: 1)
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMovieNowPlayingCalled)
    }
    
    func testCallGetMovieNowPlayingFailure() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        networkServiceProviderMock.isFlagError = true
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMovieNowPlaying(page: 1)
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMovieNowPlayingCalled)
    }
    
    func testCallGetMoviePopularSuccess() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMoviePopular(page: 1)
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMoviePopularCalled)
    }
    
    func testCallGetMoviePopularFailure() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        networkServiceProviderMock.isFlagError = true
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMoviePopular(page: 1)
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMoviePopularCalled)
    }
    
    func testCallGetMovieTopRatedSuccess() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMovieTopRated(page: 1)
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMovieTopRatedCalled)
    }
    
    func testCallGetMovieTopRatedFailure() throws {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        networkServiceProviderMock.isFlagError = true
        sut.presenter = presenter
        sut.networkService = networkService
        sut.callGetMovieTopRated(page: 1)
        XCTAssertTrue(networkServiceProviderMock.isRequestCalled)
        XCTAssertTrue(presenter.isDidGetMovieTopRatedCalled)
    }
    
    func testSaveMovieNowPlaying() {
        let model = MovieInteractorTests.generateMockModel()
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.dataService = dataService
        sut.networkService = networkService
        
        _ = sut.saveMovieNowPlaying(model: model)
        XCTAssertTrue(dataService.isSaveCalled)
    }
    
    func testSaveMoviePopular() {
        let model = MovieInteractorTests.generateMockModel()
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.dataService = dataService
        sut.networkService = networkService
        
        _ = sut.saveMoviePopular(model: model)
        XCTAssertTrue(dataService.isSaveCalled)
    }
    
    func testSaveMovieTopRated() {
        let model = MovieInteractorTests.generateMockModel()
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.dataService = dataService
        sut.networkService = networkService
        
        _ = sut.saveMovieTopRated(model: model)
        XCTAssertTrue(dataService.isSaveCalled)
    }
    
    func testSaveMovieUpcoming() {
        let model = MovieInteractorTests.generateMockModel()
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.dataService = dataService
        sut.networkService = networkService
        
        _ = sut.saveMovieUpcoming(model: model)
        XCTAssertTrue(dataService.isSaveCalled)
    }
    
    func testLoadMovieModel() {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.dataService = dataService
        sut.networkService = networkService
        
        _ = sut.loadMovieModel(section: .upcoming)
        _ = sut.loadMovieModel(section: .popular)
        _ = sut.loadMovieModel(section: .topRated)
        _ = sut.loadMovieModel(section: .nowPlaying)
        
        XCTAssertTrue(dataService.isLoadCalled)
    }
    
    func testIsNetworkOnline() {
        let networkService: NetworkService = NetworkService(networkServiceProtocol: networkServiceProviderMock)
        sut.presenter = presenter
        sut.dataService = dataService
        sut.networkService = networkService
        sut.networkMonitoringService = networkMonitoringService
        
        let isNetworkOnline = sut.isNetworkOnline()
        XCTAssertTrue(isNetworkOnline)
    }
                       
    static func generateMockModel() -> MovieModel {
        let movieDetail: MovieDetailModel = MovieDetailModel(id: 1, overview: .empty, title: .empty, posterPath: .empty, backdropPath: .empty, releaseDate: .empty)
        
        let movie: MovieModel = MovieModel(page: 1, results: [movieDetail], totalPages: 1, totalResults: 1)
        
        return movie
    }
}
