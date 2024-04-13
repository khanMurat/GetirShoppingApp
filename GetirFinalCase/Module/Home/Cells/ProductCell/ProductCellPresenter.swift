//
//  ProductCellPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 11.04.2024.
//

import Foundation

protocol ProductActionProtocol: AnyObject {
    func load()
    func addProductToBasket()
    func removeProductFromBasket()
}

protocol ProductCellPresenterProtocol : ProductActionProtocol {}

final class ProductCellPresenter {
    
    weak var view : ProductCollectionViewCell?
    
    private let product : Product
    
    init(view: ProductCollectionViewCell, product: Product) {
        self.view = view
        self.product = product
    }
    
}

extension ProductCellPresenter : ProductCellPresenterProtocol {
    func load() {
        
        self.view?.setProductName(product.name ?? "")
        self.view?.setProductPriceText(product.priceText ?? "")
        self.view?.setProductAttribute(product.attribute ?? product.shortDescription ?? "")
        self.view?.setProductImage(product.imageURL ?? product.thumbnailURL)
        self.view?.setSquareThumbnailImage(product.thumbnailURL ?? product.imageURL)
        self.view?.setStackViewColorIfIsBasket(ProductRepository.shared.checkIfProductInBasket(productID: product.id ?? ""))
        self.view?.setProductBasketCount(checkProductCount())
    }
    
    func addProductToBasket() {
        let realmProduct = product.toRealmProduct()
        
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
        
        ProductRepository.shared.removeFromBasket(productID: product.id ?? "") {[weak self] (success,count) in
            guard let self else {return}
            
            if success {
                self.view?.performRemoveFromBasketAnimation(count ?? 0)
                self.view?.setProductBasketCount(checkProductCount())
                NotificationCenter.default.post(name: .productRemovedFromBasket, object: nil, userInfo: nil)
            }
        }
    }
    
    private func checkProductCount() -> Int {
        
        return ProductRepository.shared.checkProductBasketCount(productID: product.id ?? "")
    }
}

