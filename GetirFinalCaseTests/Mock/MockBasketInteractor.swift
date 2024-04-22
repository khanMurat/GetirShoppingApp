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
    var isFetchBasketProductsCalled = false
    var isFetchSuggestedProductsCalled = false
    
    func fetchBasketProducts() {
        isFetchBasketProductsCalled = true
    }
    
    func fetchSuggestedProducts() {
        isFetchSuggestedProductsCalled = true
    }
    
    func removeAllProductFromBasket() {
        removeAllProductsCalled = true
    }
    
    func checkOutProducts() {}
    
    func setupNotifications() {}
    
    func removeNotifications() {}
    
}
