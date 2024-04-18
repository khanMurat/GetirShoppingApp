//
//  BasketCellPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//


import Foundation

protocol BasketProductCellPresenterProtocol: ProductActionProtocol {}

final class BasketProductCellPresenter {
    
    weak var view : BasketProductCollectionViewCell?
    
    private let basketProduct : RealmProduct
    
    init(view: BasketProductCollectionViewCell, basketProduct: RealmProduct) {
        self.view = view
        self.basketProduct = basketProduct
    }
}

extension BasketProductCellPresenter : BasketProductCellPresenterProtocol {
    
    func load() {
        
        self.view?.setProductName(basketProduct.name)
        self.view?.setProductPriceText(basketProduct.priceText ?? "")
        self.view?.setProductAttribute(basketProduct.attribute ?? basketProduct.shortDescription ?? "")
        self.view?.setProductImage(basketProduct.imageURL ?? basketProduct.thumbnailURL)
        self.view?.setSquareThumbnailImage(basketProduct.squareThumbnailURL ?? basketProduct.imageURL)
        self.view?.setProductBasketCount(checkProductCount())
    }
    
    func addProductToBasket() {
        
        ProductRepository.shared.addToBasket(product:basketProduct) { [weak self] success in
            guard let self else { return }
            if success {
                self.view?.setProductBasketCount(checkProductCount())
                NotificationCenter.default.post(name: .productAddedToBasket, object: nil, userInfo: nil)
            }
        }
    }
    
    func removeProductFromBasket() {
        
        ProductRepository.shared.removeFromBasket(productID: basketProduct.id) {[weak self] (success,count) in
            guard let self else {return}
            
            if success {
                self.view?.setProductBasketCount(checkProductCount())
                NotificationCenter.default.post(name: .productRemovedFromBasket, object: nil, userInfo: nil)
            }
        }
    }
    
    private func checkProductCount() -> Int {
        
        return ProductRepository.shared.checkProductBasketCount(productID: basketProduct.id)
    }
}
