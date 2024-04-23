//
//  MockBasketPresenter.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 20.04.2024.
//

import XCTest
@testable import GetirFinalCase

final class MockBasketPresenter: XCTestCase {
    
    var presenter: BasketPresenter!
    var mockView: MockBasketViewController!
    var mockRouter: MockBasketRouter!
    var mockInteractor: MockBasketInteractor!
    
    
    override func setUp() {
        super.setUp()
        mockView = MockBasketViewController()
        mockRouter = MockBasketRouter()
        mockInteractor = MockBasketInteractor()
        presenter = BasketPresenter(view: mockView, router: mockRouter, interactor: mockInteractor)
        
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        super.tearDown()
        
    }
    
    func testInitialState() {
        XCTAssertFalse(mockView.isSetupViewsCalled)
        XCTAssertFalse(mockView.isShowLoadingViewCalled)
        XCTAssertEqual(mockView.setupViewsCallCount, 0)
        XCTAssertEqual(mockView.showLoadingViewCallCount, 0)
        XCTAssertNil(mockView.titleSet)
    }
    
    func testAfterViewDidLoad() {
        presenter.viewdidLoad()
        
        XCTAssertTrue(mockView.isSetupViewsCalled)
        XCTAssertTrue(mockView.isShowLoadingViewCalled)
        XCTAssertEqual(mockView.setupViewsCallCount, 1)
        XCTAssertEqual(mockView.showLoadingViewCallCount, 1)
        XCTAssertEqual(mockView.titleSet, "Sepetim")
    }
    
    func testTotalPriceIsCorrectlyPassedToView() {
        
        let testTotalPrice = 100.0
        presenter.fetchBasketProductsTotalPriceOutput(testTotalPrice)
        XCTAssertEqual(mockView.totalPrice, testTotalPrice)
    }
    
    func testFetchBasketProductsIsCalled() {
        
        mockInteractor.fetchBasketProducts()
        XCTAssertTrue(mockInteractor.isFetchBasketProductsCalled)
        XCTAssertEqual(mockInteractor.fetchBasketProductsCallCount, 1)
    }
    
    func testRemoveAllProductsClearsProductList() {
        
        mockInteractor.removeAllProductFromBasket()
        XCTAssertTrue(mockInteractor.removeAllProductsCalled)
        XCTAssertEqual(mockInteractor.removeAllProductsCallCount, 1)
    }
    
    func testNumberOfSectionsReturnsCorrectValue() {
        
        let expectedSection = 2
        XCTAssertEqual(presenter.numberOfSections(), expectedSection)
    }
}
