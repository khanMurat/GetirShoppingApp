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
    func checkOutProducts()
    func setupNotifications()
    func removeNotifications()
}

protocol BasketInteractorOutputProtocol : AnyObject {
    func fetchBasketProductsOutput(_ result : [RealmProduct])
    func fetchSuggestedProductsOutput(_ result : [SuggestedProduct])
    func fetchBasketProductsTotalPriceOutput(_ result : Double)
    func removeAllProductFromBasketOutput(_ result : Bool)
    func checkOutProductsOutput(_ result : Bool)
    func checkBasketIsEmpty(_ result : Bool)
    func setupError(_ result : Error)
}

final class BasketInteractor {
    
    weak var output : BasketInteractorOutputProtocol?
    
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
        
        if basketItemsTotalPrice == 0 {
            self.output?.checkBasketIsEmpty(true)
        }
    }
    
    func fetchSuggestedProducts() {
        ProductServiceManager.shared.getHorizontalProduct()
            .subscribe { [weak self] suggestedProduct in
                self?.output?.fetchSuggestedProductsOutput(suggestedProduct[0].products ?? [])
            }onFailure: { error in
                self.output?.setupError(error)
            }.disposed(by: disposeBag)
    }
    
    func removeAllProductFromBasket() {
        ProductRepository.shared.clearBasket { isSuccess in
            self.output?.removeAllProductFromBasketOutput(isSuccess)
        }
    }
    
    func checkOutProducts() {
        ProductRepository.shared.clearBasket { isSuccess in
            self.output?.checkOutProductsOutput(isSuccess)
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
