//
//  SuggestedProductCellPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import Foundation

protocol SuggestedProductCellPresenterProtocol : ProductActionProtocol {

}

final class SuggestedProductCellPresenter {
    
    weak var view : ProductCollectionViewCell?
    
    private let suggestedProduct : SuggestedProduct
    
    init(view: ProductCollectionViewCell, suggestedProduct: SuggestedProduct) {
        self.view = view
        self.suggestedProduct = suggestedProduct
    }
}

extension SuggestedProductCellPresenter : SuggestedProductCellPresenterProtocol {
    func load() {
        
        self.view?.setProductName(suggestedProduct.name ?? "")
        self.view?.setProductPriceText(suggestedProduct.priceText ?? "")
        self.view?.setProductImage(suggestedProduct.imageURL ?? suggestedProduct.squareThumbnailURL)
        self.view?.setSquareThumbnailImage(suggestedProduct.squareThumbnailURL ?? suggestedProduct.imageURL)
        self.view?.setStackViewColorIfIsBasket(ProductRepository.shared.checkIfProductInBasket(productID: suggestedProduct.id ?? ""))
        self.view?.setProductBasketCount(checkProductCount())
    }
    
    func addProductToBasket() {
        let realmProduct = suggestedProduct.toRealmProduct()

        ProductRepository.shared.addToBasket(product:realmProduct) { [weak self] success in
            guard let self = self else { return }
            if success {
                self.view?.performAddToBasketAnimation()
                self.view?.setProductBasketCount(checkProductCount())
                NotificationCenter.default.post(name: .productAddedToBasket, object: nil, userInfo: nil)
            }
        }
    }
    
    func removeProductFromBasket() {
        
        ProductRepository.shared.removeFromBasket(productID: suggestedProduct.id ?? "") {[weak self] (success,count) in
            guard let self else {return}
            
            if success {
                self.view?.performRemoveFromBasketAnimation(count ?? 0)
                self.view?.setProductBasketCount(checkProductCount())
                NotificationCenter.default.post(name: .productRemovedFromBasket, object: nil, userInfo: nil)
            }
        }
    }
    
    private func checkProductCount() -> Int {
        
        return ProductRepository.shared.checkProductBasketCount(productID: suggestedProduct.id ?? "")
    }
}
