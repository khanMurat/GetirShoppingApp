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
}

protocol BasketInteractorOutputProtocol : AnyObject {
    func fetchBasketProductsOutput(_ result : [RealmProduct])
    func fetchSuggestedProductsOutput(_ result : [SuggestedProduct])
    func fetchBasketProductsTotalPriceOutput(_ result : Double)
}

final class BasketInteractor {
    
    var output : BasketInteractorOutputProtocol?
    
    private let disposeBag = DisposeBag()
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
}
