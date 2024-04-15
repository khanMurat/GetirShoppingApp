//
//  BasketInteractor.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation
import RxSwift

protocol BasketInteractorProtocol : AnyObject {
    func fetchBasketProducts()
    func fetchSuggestedProducts()
    func removeAllProductFromBasket()
    func setupNotifications()
    func removeNotifications()
}

protocol BasketInteractorOutputProtocol : AnyObject {
    func fetchBasketProductsOutput(_ result : [RealmProduct])
    func fetchSuggestedProductsOutput(_ result : [SuggestedProduct])
    func fetchBasketProductsTotalPriceOutput(_ result : Double)
    func removeAllProductFromBasketOutput(_ result : Bool)
}

final class BasketInteractor {
    
    var output : BasketInteractorOutputProtocol?
    
    private let disposeBag = DisposeBag()
    
    @objc private func basketChanged() {
        fetchBasketProducts()
    }
}

extension BasketInteractor : BasketInteractorProtocol {
    
    func fetchBasketProducts() {
        let basketProducts = ProductRepository.shared.getAllBasketItems()
        
        let basketItemsTotalPrice = basketProducts.reduce(0.0) { (total, product) -> Double in
            total + (product.price * Double(product.basketCount))
        }
        self.output?.fetchBasketProductsOutput(basketProducts)
        self.output?.fetchBasketProductsTotalPriceOutput(basketItemsTotalPrice)
        
    }
    
    func fetchSuggestedProducts() {
        ProductServiceManager.shared.getHorizontalProduct()
            .subscribe { [weak self] suggestedProduct in
                self?.output?.fetchSuggestedProductsOutput(suggestedProduct[0].products ?? [])
            }onFailure: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
    func removeAllProductFromBasket() {
        ProductRepository.shared.clearBasket { isSuccess in
            self.output?.removeAllProductFromBasketOutput(isSuccess)
        }
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
}
