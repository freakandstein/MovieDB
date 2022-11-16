//
//  SplashPresenterTests.swift
//  MovieDBTests
//
//  Created by Satrio Wicaksono on 15/11/22.
//

import XCTest
@testable import MovieDB

final class SplashPresenterTests: XCTestCase {

    //View Mock
    class SplashViewMock: SplashPresenterToView {
        var presenter: SplashViewToPresenter?
        
        var isHideLoadingCalled: Bool = false
        func hideLoading() {
            isHideLoadingCalled = true
        }
        
        var isShowLoadingCalled: Bool = false
        func showLoading() {
            isShowLoadingCalled = true
        }
    }
    
    //Router Mock
    class SplashRouterMock: SplashPresenterToRouter {
        var window: UIWindow?
        
        var isNavigateToMainCalled: Bool = false
        func navigateToMain() {
            isNavigateToMainCalled = true
        }
    }
    
    var sut: SplashPresenter = SplashPresenter()
    var view: SplashViewMock = SplashViewMock()
    var router: SplashRouterMock = SplashRouterMock()
    
    override func setUpWithError() throws {
        sut.view = view
    }
    
    func testViewDidLoad() throws {
        sut.viewDidLoad()
        XCTAssertTrue(view.isShowLoadingCalled)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.view.isHideLoadingCalled)
            XCTAssertTrue(self.router.isNavigateToMainCalled)
        }
    }
}
