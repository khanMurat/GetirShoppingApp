//
//  BasketRouter.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation

enum BasketRoutes {
    case homeView
}

protocol BasketRouterProtocol : AnyObject {
    func navigate(_ route: BasketRoutes)}

final class BasketRouter {
    
    weak var viewController: BasketViewController?
    
    static func createModule() -> BasketViewController {
        
        let view = BasketViewController()
        let interactor = BasketInteractor()
        let router = BasketRouter()
        
        let presenter = BasketPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
}

extension BasketRouter : BasketRouterProtocol {
    func navigate(_ route: BasketRoutes) {
        
    }
}
