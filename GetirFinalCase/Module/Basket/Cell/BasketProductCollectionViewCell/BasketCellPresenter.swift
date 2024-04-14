//
//  BasketCellPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//


import Foundation

protocol BasketProductCellPresenterProtocol: AnyObject {
    func load()
    //    func addProductToBasket()
    //    func removeProductFromBasket()
}

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
        self.view?.setSquareThumbnailImage(basketProduct.thumbnailURL ?? basketProduct.imageURL)
    }
}
