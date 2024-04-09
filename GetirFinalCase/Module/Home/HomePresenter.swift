//
//  HomePresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation

protocol HomePresenterProtocol : AnyObject {
    func viewdidLoad()
    func numberOfItems() -> Int
    func product(_ index : Int) -> Product?
    func didSelectRowAt(index:Int)
    func tappedBasket()
    
}

final class HomePresenter {
    
    unowned var view : HomeViewControllerProtocol!
    
    let router : HomeRouterProtocol!
    let interactor : HomeInteractorProtocol!
    private var product : [Product] = []
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension HomePresenter : HomePresenterProtocol {
    func viewdidLoad() {
        fetchProduct()
    }
    
    func numberOfItems() -> Int {
        return product.count
    }
    
    func product(_ index: Int) -> Product? {
        
        return product[index]
    }
    
    func didSelectRowAt(index: Int) {
 
    }
    
    func tappedBasket() {
        
    }
    
    private func fetchProduct(){
        // showLoading
        
        interactor.fetchProducts()
    }
    
}

extension HomePresenter : HomeInteractorOutputProtocol {
    func fetchProductsOutput(result: [Product]) {
        // hide loading
        self.product = result
    }

}
