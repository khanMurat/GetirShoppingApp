//
//  SplashRouter.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation


enum SplashRoutes {
    case homeView
}

protocol SplashRouterProtocol : AnyObject {
    func navigate(_ route : SplashRoutes)
}

final class SplashRouter {
    
    weak var viewController : SplashViewController?
    
    static func createModule() -> SplashViewController {
        
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
}

extension SplashRouter : SplashRouterProtocol {
    
    func navigate(_ route: SplashRoutes) {
        
        switch route {
        case .homeView:
            print("GO HOME VİEW")
        }
    }
}
