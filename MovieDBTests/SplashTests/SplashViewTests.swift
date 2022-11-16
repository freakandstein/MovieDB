//
//  SplashTests.swift
//  MovieDBTests
//
//  Created by Satrio Wicaksono on 15/11/22.
//

import XCTest
@testable import MovieDB

final class SplashViewTests: XCTestCase {

    //Presenter Mock
    class SplashPresenterMock: SplashViewToPresenter {
        var view: SplashPresenterToView?
        var router: SplashPresenterToRouter?
        var interactor: SplashPresenterToInteractor?
        
        var isViewDidLoadCalled: Bool = false
        func viewDidLoad() {
            isViewDidLoadCalled = true
        }
    }
    
    var sut: SplashView = SplashView()
    var presenter: SplashPresenterMock = SplashPresenterMock()
    
    override func setUpWithError() throws {
        sut.presenter = presenter
    }

    
    func testViewDidLoad() throws {
        sut.viewDidLoad()
        XCTAssertTrue(presenter.isViewDidLoadCalled)
    }

}
