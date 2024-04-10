//
//  ProductCellPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 11.04.2024.
//

import Foundation

protocol ProductCellPresenterProtocol : AnyObject {
    
    func load()
    
}

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
        self.view?.setProductImage(product.imageURL ?? product.thumbnailURL)
        self.view?.setSquareThumbnailImage(product.thumbnailURL ?? product.imageURL)
    }
}
