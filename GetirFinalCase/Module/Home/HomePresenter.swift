//
//  HomePresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation

protocol HomePresenterProtocol : AnyObject {
    func viewdidLoad()
    func numberOfHorizontalItems() -> Int
    func numberOfVerticalItems() -> Int
    func horizontalProduct(_ index : Int) -> SuggestedProduct?
    func verticalProduct(_ index: Int) -> Product?
    func didSelectRowAt(index:Int)
    func tappedBasket()
    func removeNotifications()
}

final class HomePresenter {
    
    unowned var view : HomeViewControllerProtocol!
    
    let router : HomeRouterProtocol!
    let interactor : HomeInteractorProtocol!
    private var horizontalProduct : [SuggestedProduct] = []
    private var verticalProduct : [Product] = []
    private var totalPrice : Double = 0.0
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension HomePresenter : HomePresenterProtocol {

    func viewdidLoad() {
        fetchVerticalProduct()
        fetchHorizontalProduct()
        fetchTotalBasketPrice()
        setupNotifications()
        view.setupCollectionView()
        view.setupBarButtonItem(totalPrice)
    }
    
    func numberOfHorizontalItems() -> Int {
        return horizontalProduct.count
    }
    
    func numberOfVerticalItems() -> Int {
        return verticalProduct.count
    }
    
    func horizontalProduct(_ index: Int) -> SuggestedProduct? {
        
        return horizontalProduct[index]
    }
    
    func verticalProduct(_ index: Int) -> Product? {
        
        return verticalProduct[index]
    }
    
    func didSelectRowAt(index: Int) {
        print(horizontalProduct[index].id)
    }
    
    func tappedBasket() {
        
    }
    
    func removeNotifications() {
        interactor.removeNotifications()
    }
    
    private func fetchHorizontalProduct(){
        // showLoading
        interactor.fetchHorizontalProducts()
    }
    
    private func fetchVerticalProduct(){
        interactor.fetchVerticalProducts()
    }
    
    private func fetchTotalBasketPrice(){
        interactor.fetchBasketProducts()
    }
    
    private func setupNotifications(){
        interactor.setupNotifications()
    }
}

extension HomePresenter : HomeInteractorOutputProtocol {
    
    func fetchHorizontalProductsOutput(result: [SuggestedProduct]) {
        self.horizontalProduct = result
        self.view.reloadData()
    }
    
    func fetchVerticalProductsOutput(result: [Product]) {
        self.verticalProduct = result
        self.view.reloadData()
    }
    
    func fetchBasketProductsOutput(result: Double) {
        self.totalPrice = result
        self.view.setupBarButtonItem(totalPrice)
    }
}
