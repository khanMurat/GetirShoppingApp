//
//  DetailPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation

protocol DetailPresenterProtocol : AnyObject {
    func viewdidLoad()
    func addProductToBasket()
    func removeProductFromBasket()
    func removeNotifications()
    func productCheckForBasket()
}

final class DetailPresenter {
    
    unowned var view : DetailViewControllerProtocol!
    let router : DetailRouterProtocol!
    let interactor : DetailInteractorProtocol!
    
    let suggestedProduct : SuggestedProduct?
    let product : Product?
    
    private var totalPrice : Double = 0.0
    
    init(view: DetailViewControllerProtocol, router: DetailRouterProtocol, interactor: DetailInteractorProtocol,suggestedProduct:SuggestedProduct?,product:Product?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.suggestedProduct = suggestedProduct
        self.product = product
    }
    
}

extension DetailPresenter : DetailPresenterProtocol {
    
    func viewdidLoad() {
        
        if let product = product {
            view.setProductImage(product.imageURL ?? "")
            view.setProductName(product.name ?? "")
            view.setProductPrice(product.priceText ?? "")
            view.setProductAttribute(product.attribute ?? product.shortDescription ?? "")
        } else if let suggestedProduct = suggestedProduct {
            view.setProductImage(suggestedProduct.imageURL ?? "")
            view.setProductName(suggestedProduct.name ?? "")
            view.setProductPrice(suggestedProduct.priceText ?? "")
            view.setProductAttribute(suggestedProduct.shortDescription ?? "")
        }
        view.setupView()
        view.setupActions()
        fetchTotalBasketPrice()
        setupNotifications()
        productCheckForBasket()
    }
        
    func addProductToBasket(){
        
        if let product = product {
            
            let realmProduct = product.toRealmProduct()
            
            interactor.addProductToBasket(product: realmProduct)
            
        }else if let suggestedProduct = suggestedProduct {
            
            let realmProduct = suggestedProduct.toRealmProduct()
            
            interactor.addProductToBasket(product: realmProduct)
        }
    }
    
    func removeProductFromBasket() {
        if let product = product {
        
            interactor.removeProductFromBasket(productID: product.id ?? "")
            
        }else if let suggestedProduct = suggestedProduct {
            
            interactor.removeProductFromBasket(productID: suggestedProduct.id ?? "")
        }
    }
    
    func removeNotifications() {
        interactor.removeNotifications()
    }
    
    func productCheckForBasket() {
        
        if let product = product {
            
            interactor.checkIfProductInBasket(productID: product.id ?? "")
            
        }else if let suggestedProduct = suggestedProduct {
            
            interactor.checkIfProductInBasket(productID: suggestedProduct.id ?? "")
        }
    }
    
    private func fetchTotalBasketPrice(){
        interactor.fetchBasketProducts()
    }
    
    private func setupNotifications(){
        interactor.setupNotifications()
    }
    
}

extension DetailPresenter : DetailInteractorOutputProtocol {

    func fetchBasketProductsOutput(result: Double) {
        self.totalPrice = result
        self.view.setupBarButtonItem(totalPrice)
    }
    
    func addProductToBasketOutput(result: Bool) {
        self.view.setupBottomView(result)
    }
    
    func removeProductFromBasket(result: Bool) {
        self.view.setupBottomView(result)
    }
    
    func checkIfProductInBasketOutput(result: Bool) {
        self.view.setupBottomView(result)
    }
    
    func checkProductBasketCountOutput(result: Int) {
        self.view.setupStepperValue(result)
    }
    
}
