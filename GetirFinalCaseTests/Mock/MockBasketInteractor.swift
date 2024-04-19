//
//  MockBasketInteractor.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 20.04.2024.
//

import XCTest
@testable import GetirFinalCase

final class MockBasketInteractor: XCTestCase,BasketInteractorProtocol {
    
    var removeAllProductsCalled = false
    
    func fetchBasketProducts() {}
    
    func fetchSuggestedProducts() {}
    
    func removeAllProductFromBasket() {
        removeAllProductsCalled = true
    }
    
    func checkOutProducts() {}
    
    func setupNotifications() {}
    
    func removeNotifications() {}
    
}
