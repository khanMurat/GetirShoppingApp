//
//  SuggestedProductCellPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import Foundation

protocol SuggestedProductCellPresenterProtocol : AnyObject {
    
    func load()
    
}

final class SuggestedProductCellPresenter {
    
    weak var view : SuggestedProductCollectionViewCell?
    
    private let suggestedProduct : SuggestedProduct
    
    init(view: SuggestedProductCollectionViewCell, suggestedProduct: SuggestedProduct) {
        self.view = view
        self.suggestedProduct = suggestedProduct
    }
    
}

extension SuggestedProductCellPresenter : SuggestedProductCellPresenterProtocol {
    func load() {
        
        self.view?.setProductName(suggestedProduct.name ?? "")
        self.view?.setProductPriceText(suggestedProduct.priceText ?? "")
        
    }
}
