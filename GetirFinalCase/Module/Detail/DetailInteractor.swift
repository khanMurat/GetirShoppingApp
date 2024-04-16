//
//  DetailInteractor.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation

protocol DetailInteractorProtocol : AnyObject {
    
    func fetchBasketProducts()
    func setupNotifications()
    func removeNotifications()
    func addProductToBasket(product:RealmProduct)
    func removeProductFromBasket(productID:String)
    func checkIfProductInBasket(productID:String)
    func checkProductCount(productID:String)
}

protocol DetailInteractorOutputProtocol : AnyObject {
    func fetchBasketProductsOutput(result : Double)
    func addProductToBasketOutput(result : Bool)
    func removeProductFromBasket(result : Bool)
    func checkIfProductInBasketOutput(result:Bool)
    func checkProductBasketCountOutput(result:Int)
}


final class DetailInteractor {
    
    weak var output : DetailInteractorOutputProtocol?
    
    @objc private func basketChanged() {
        fetchBasketProducts()
    }
}

extension DetailInteractor : DetailInteractorProtocol {
    
    func fetchBasketProducts() {
        let basketItems = ProductRepository.shared.getAllBasketItems()
        
        let basketItemsTotalPrice = basketItems.reduce(0.0) { (total, product) -> Double in
            total + (product.price * Double(product.basketCount))
        }
        output?.fetchBasketProductsOutput(result: basketItemsTotalPrice)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(basketChanged),
            name: .productAddedToBasket,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(basketChanged),
            name: .productRemovedFromBasket,
            object: nil
        )
    }
    
    func removeNotifications(){
        NotificationCenter.default.removeObserver(self, name: .productAddedToBasket, object: nil)
        NotificationCenter.default.removeObserver(self, name: .productRemovedFromBasket, object: nil)
    }
    
    func addProductToBasket(product:RealmProduct) {
        
        ProductRepository.shared.addToBasket(product:product) { [weak self] success in
            guard let self = self else { return }
            if success {
                self.output?.addProductToBasketOutput(result: true)
                self.output?.checkIfProductInBasketOutput(result: ProductRepository.shared.checkIfProductInBasket(productID: product.id))
                self.output?.checkProductBasketCountOutput(result: checkProductCount(productID: product.id))
                NotificationCenter.default.post(name: .productAddedToBasket, object: nil, userInfo: nil)
            }
        }
    }
    
    func removeProductFromBasket(productID:String) {
        
        ProductRepository.shared.removeFromBasket(productID: productID) {[weak self] (success,count) in
            guard let self else {return}
            
            if success {
                self.output?.removeProductFromBasket(result: true)
                self.output?.checkIfProductInBasketOutput(result: ProductRepository.shared.checkIfProductInBasket(productID: productID))
                self.output?.checkProductBasketCountOutput(result: checkProductCount(productID: productID))
                NotificationCenter.default.post(name: .productRemovedFromBasket, object: nil, userInfo: nil)
            }
        }
    }
    
    func checkIfProductInBasket(productID:String) {
        self.output?.checkIfProductInBasketOutput(result: ProductRepository.shared.checkIfProductInBasket(productID: productID))
    }
    
    func checkProductCount(productID: String) {
        self.output?.checkProductBasketCountOutput(result: checkProductCount(productID: productID))
    }
    
    private func checkProductCount(productID:String) -> Int {
        
        return ProductRepository.shared.checkProductBasketCount(productID: productID)
    }
}
