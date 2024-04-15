//
//  BasketRouter.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation
import UIKit

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
        guard let window = viewController?.view.window else { return }
        let homeVC = HomeRouter.createModule()
        let navigationController = UINavigationController(rootViewController: homeVC)
        window.rootViewController = navigationController
    }
}
