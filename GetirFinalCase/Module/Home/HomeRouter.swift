//
//  HomeRouter.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation

protocol HomeRouterProtocol : AnyObject {
    
}

final class HomeRouter {
    
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
}

extension HomeRouter : HomeRouterProtocol {
    
}
