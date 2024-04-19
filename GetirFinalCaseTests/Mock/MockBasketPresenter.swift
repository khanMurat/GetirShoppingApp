//
//  MockBasketPresenter.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 20.04.2024.
//

import XCTest
@testable import GetirFinalCase

final class MockBasketPresenter: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTotalPriceIsCorrectlyPassedToView() {
        let mockView = MockBasketViewController()
        let mockRouter = MockBasketRouter()
        let mockInteractor = MockBasketInteractor()
//        let presenter = BasketPresenter(view: mockView, router: mockRouter, interactor: mockInteractor)

        // Simulate the interactor output that would be called after fetching products
        let testTotalPrice = 100.0
//        presenter.fetchBasketProductsTotalPriceOutput(testTotalPrice)

        // Assert to check if the totalPrice passed to the view is correct
        XCTAssertEqual(mockView.totalPrice, testTotalPrice)
    }
    
}
