//
//  DetailRouter.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation
import UIKit

enum DetailRoutes {
    case basketView
}

protocol DetailRouterProtocol : AnyObject {
    //    func navigate(_ route : DetailRoutes)
}

final class DetailRouter: DetailRouterProtocol {
    
    weak var viewController : DetailViewController?
    
    static func createModule(withProduct product: Product) -> DetailViewController {
        
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor, suggestedProduct: nil, product: product)
        
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
    static func createModule(withSuggestedProduct suggestedProduct: SuggestedProduct) -> DetailViewController {
        
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor, suggestedProduct: suggestedProduct, product: nil)
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    
}

extension SplashRouter : DetailRouterProtocol {
    
}
