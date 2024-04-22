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
    
    func testTotalPriceIsCorrectlyPassedToView() {
        let mockView = MockBasketViewController()
        let mockRouter = MockBasketRouter()
        let mockInteractor = MockBasketInteractor()
        let presenter = BasketPresenter(view: mockView, router: mockRouter, interactor: mockInteractor)
        
        let testTotalPrice = 100.0
        presenter.fetchBasketProductsTotalPriceOutput(testTotalPrice)
        
        // XCTAssert check total price pass correctly and equal with view's total price
        
        XCTAssertEqual(mockView.totalPrice, testTotalPrice)
    }
    
    func testRemoveAllProductsClearsProductList() {

        presenter.removeAllProduct()
        
        // XCTAssert Check if remove all product
        
        XCTAssertTrue(mockInteractor.removeAllProductsCalled)
    }
    
    func testNumberOfSectionsReturnsCorrectValue() {

        // XCTAssert check number of sections is equal same number
        
        XCTAssertEqual(presenter.numberOfSections(), 3)
    }
    
}
