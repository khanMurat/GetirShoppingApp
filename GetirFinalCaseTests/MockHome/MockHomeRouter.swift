//
//  MockHomeRouter.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 23.04.2024.
//

import Foundation
@testable import GetirFinalCase

final class MockHomeRouter: HomeRouterProtocol {
    
    var lastRoute: HomeRoutes?
    
    func navigate(_ route: HomeRoutes) {
        lastRoute = route
    }
}
