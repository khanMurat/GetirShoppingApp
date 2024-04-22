//
//  MockBasketRouter.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 20.04.2024.
//

@testable import GetirFinalCase

final class MockBasketRouter: BasketRouterProtocol {
    
    var lastRoute: BasketRoutes?
    
    func navigate(_ route: BasketRoutes) {
        lastRoute = route
    }

}
