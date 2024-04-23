//
//  MockHomePresenter.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 23.04.2024.
//

import XCTest
@testable import GetirFinalCase

final class MockHomePresenter : XCTestCase {
    
    var presenter: HomePresenter!
    var mockHomeView : MockHomeViewController!
    var mockHomeRouter : MockHomeRouter!
    var mockHomeInteractor : MockHomeInteractor!
    
    
    override func setUp() {
        super.setUp()
        mockHomeView = MockHomeViewController()
        mockHomeRouter = MockHomeRouter()
        mockHomeInteractor = MockHomeInteractor()
        presenter = HomePresenter(view: mockHomeView, router: mockHomeRouter, interactor: mockHomeInteractor)
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        mockHomeView = nil
        mockHomeRouter = nil
        mockHomeInteractor = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertFalse(mockHomeView.isSetupCollectionViewsCalled)
        XCTAssertEqual(mockHomeView.setupCollectionViewsCallCount, 0)
        XCTAssertFalse(mockHomeView.isReloadDataCalled)
        XCTAssertEqual(mockHomeView.reloadDataCallCount, 0)
        XCTAssertNil(mockHomeView.titleSet)
        XCTAssertNil(mockHomeView.totalPrice)
    }
    
    func testAfterViewDidLoad() {
        presenter.viewdidLoad()
        
        XCTAssertTrue(mockHomeView.isSetupCollectionViewsCalled)
        XCTAssertTrue(mockHomeView.isShowLoadingViewCalled)
        
        XCTAssertEqual(mockHomeView.setupCollectionViewsCallCount, 1)
        XCTAssertEqual(mockHomeView.showLoadingViewCallCount, 1)
        XCTAssertEqual(mockHomeView.titleSet, "Ürünler")
        
        XCTAssertTrue(mockHomeInteractor.isFetchVerticalProductsCalled)
        XCTAssertEqual(mockHomeInteractor.fetchVerticalProductsCallCount, 1)
        
        XCTAssertTrue(mockHomeInteractor.isNotificationSetup)
        XCTAssertEqual(mockHomeInteractor.notificationSetupCallCount, 1)
    }
    
    func testFetchVerticalProductsSuccess() {
        XCTAssertEqual(presenter.numberOfHorizontalItems(), 0)
        presenter.fetchVerticalProductsOutput(result: ProductCategory.response[0].products!)
        XCTAssertEqual(presenter.numberOfVerticalItems(), 38)
        XCTAssertEqual(presenter.verticalProduct(0)?.price, 65.3)
    }
    
    func testTotalPriceIsCorrectlyPassedToView() {
        
        let testTotalPrice = 100.0
        presenter.fetchBasketProductsOutput(result:testTotalPrice)
        XCTAssertEqual(mockHomeView.totalPrice, testTotalPrice)
    }
    
}

extension ProductCategory {
    static var response: [ProductCategory] {
        let bundle = Bundle(for: MockHomePresenter.self)
        let path = bundle.path(forResource: "Products", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let productResponse = try! JSONDecoder().decode([ProductCategory].self, from: data)
        return productResponse
    }
}
