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
    func product(_ index : Int) -> SuggestedProduct?
    func didSelectRowAt(index:Int)
    func tappedBasket()
    
}

final class HomePresenter {
    
    unowned var view : HomeViewControllerProtocol!
    
    let router : HomeRouterProtocol!
    let interactor : HomeInteractorProtocol!
    private var product : [SuggestedProduct] = []
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension HomePresenter : HomePresenterProtocol {

    func viewdidLoad() {
        fetchProduct()
        view.setupCollectionView()
    }
    
    func numberOfItems() -> Int {
        return product.count
    }
    
    func product(_ index: Int) -> SuggestedProduct? {
        
        return product[index]
    }
    
    func didSelectRowAt(index: Int) {
        print(product[index].id)
    }
    
    func tappedBasket() {
        
    }
    
    private func fetchProduct(){
        // showLoading
        interactor.fetchProducts()
        
    }
    
}

extension HomePresenter : HomeInteractorOutputProtocol {
    func fetchProductsOutput(result: [SuggestedProduct]) {
        // hide loading
        self.product = result
        view.reloadData()
    }

}
