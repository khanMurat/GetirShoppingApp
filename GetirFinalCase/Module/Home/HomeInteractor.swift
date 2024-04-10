//
//  HomeInteractor.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation
import RxSwift

protocol HomeInteractorProtocol : AnyObject {
    func fetchProducts()
}

protocol HomeInteractorOutputProtocol : AnyObject {
    func fetchProductsOutput(result : [SuggestedProduct])
}

final class HomeInteractor {
    
    var output : HomeInteractorOutputProtocol?
    private let disposeBag = DisposeBag()
    
}

extension HomeInteractor : HomeInteractorProtocol {
    func fetchProducts() {
        
        ProductServiceManager.shared.getHorizontalProduct()
            .subscribe { [weak self] suggestedProduct in
                self?.output?.fetchProductsOutput(result: suggestedProduct[0].products)
                
            }onFailure: { error in
                print(error)
            }.disposed(by: disposeBag)
        
        //        self.output?.fetchProductsOutput(result: []) // backenddedn çektiğimiz productları göndereceğiz !
        
    }
}
