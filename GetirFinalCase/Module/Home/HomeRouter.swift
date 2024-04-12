//
//  HomeRouter.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation

enum HomeRoutes {
    case detailView(product: Product)
    case detailViewSuggested(suggestedProduct: SuggestedProduct)
}

protocol HomeRouterProtocol : AnyObject {
    func navigate(_ route: HomeRoutes)}

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
    
    func navigate(_ route: HomeRoutes) {
         switch route {
         case .detailView(let product):
             let detailVC = DetailRouter.createModule(withProduct: product)
             viewController?.navigationController?.pushViewController(detailVC, animated: true)
         case .detailViewSuggested(let suggestedProduct):
             let detailVC = DetailRouter.createModule(withSuggestedProduct: suggestedProduct)
             viewController?.navigationController?.pushViewController(detailVC, animated: true)
         }
     }
}
