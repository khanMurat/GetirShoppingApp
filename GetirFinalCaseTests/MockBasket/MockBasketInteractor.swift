//
//  MockBasketInteractor.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 20.04.2024.
//

import Foundation
@testable import GetirFinalCase

final class MockBasketInteractor: BasketInteractorProtocol {
    
    var removeAllProductsCalled = false
    var removeAllProductsCallCount = 0
    
    var isFetchBasketProductsCalled = false
    var fetchBasketProductsCallCount = 0
    
    var isFetchSuggestedProductsCalled = false
    var fetchSuggestedProductsCallCount = 0
    
    func fetchBasketProducts() {
        isFetchBasketProductsCalled = true
        fetchBasketProductsCallCount += 1
    }
    
    func fetchSuggestedProducts() {
        isFetchSuggestedProductsCalled = true
        fetchSuggestedProductsCallCount += 1
    }
    
    func removeAllProductFromBasket() {
        removeAllProductsCalled = true
        removeAllProductsCallCount += 1
    }
    
    func checkOutProducts() {}
    
    func setupNotifications() {}
    
    func removeNotifications() {}
    
}

