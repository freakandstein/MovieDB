//
//  MovieViewTests.swift
//  MovieDBTests
//
//  Created by Satrio Wicaksono on 15/11/22.
//

import XCTest
@testable import MovieDB

final class MovieViewTests: XCTestCase {

    //Presenter Mock
    class MoviePresenterMock: MovieViewToPresenter {
        var router: MoviePresenterToRouter?
        var view: MoviePresenterToView?
        var interactor: MoviePresenterToInteractor?
        var popularMovie: MovieModel?
        var upcomingMovie: MovieModel?
        var nowPlayingMovie: MovieModel?
        var topRatedMovie: MovieModel?
        
        var isViewDidLoadCalled: Bool = false
        func viewDidLoad() {
            isViewDidLoadCalled = true
        }
        
        var isNavigateToMovieDetailCalled: Bool = false
        func navigateToMovieDetail(section: MainTableViewIndex, row: Int) {
            isNavigateToMovieDetailCalled = true
        }
        
        var isLoadmoreCalled: Bool = false
        func loadmore(section: MainTableViewIndex, currentPage: Int) {
            isLoadmoreCalled = true
        }
    }
    
    var sut: MovieView = MovieView()
    var presenter: MoviePresenterMock = MoviePresenterMock()
    
    override func setUpWithError() throws {
        sut.presenter = presenter
    }

    func testViewDidLoad() throws {
        sut.viewDidLoad()
        XCTAssertTrue(presenter.isViewDidLoadCalled)
    }

}
