//
//  BasketPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation

protocol BasketPresenterProtocol : AnyObject {
    
}

final class BasketPresenter {
    
    unowned var view : BasketViewController!
    
    let router : BasketRouterProtocol!
    
    let interactor : BasketInteractorProtocol!
    
    init(view: BasketViewController, router: BasketRouterProtocol, interactor: BasketInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension BasketPresenter : BasketPresenterProtocol {
    
    
}

extension BasketPresenter : BasketInteractorOutputProtocol {
    
}
