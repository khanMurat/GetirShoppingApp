//
//  MockHomeInteractor.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 23.04.2024.
//

import Foundation
@testable import GetirFinalCase

final class MockHomeInteractor : HomeInteractorProtocol {
    
    var isFetchVerticalProductsCalled = false
    var fetchVerticalProductsCallCount = 0
    
    var isFetchBasketProductsCalled = false
    var fetchBasketProductsCallCount = 0
    
    var isNotificationSetup = false
    var notificationSetupCallCount = 0
    
    func fetchHorizontalProducts() {}
    
    func fetchVerticalProducts() {
        isFetchVerticalProductsCalled = true
        fetchVerticalProductsCallCount += 1
    }
    
    func fetchBasketProducts() {
        isFetchBasketProductsCalled = true
        fetchBasketProductsCallCount += 1
    }
    
    func setupNotifications() {
        isNotificationSetup = true
        notificationSetupCallCount += 1
    }
    
    func removeNotifications() {}
    
}
