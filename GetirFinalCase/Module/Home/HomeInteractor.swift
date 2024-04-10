//
//  HomeInteractor.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation
import RxSwift

protocol HomeInteractorProtocol : AnyObject {
    func fetchHorizontalProducts()
    func fetchVerticalProducts()
}

protocol HomeInteractorOutputProtocol : AnyObject {
    func fetchHorizontalProductsOutput(result : [SuggestedProduct])
    func fetchVerticalProductsOutput(result : [Product])
}

final class HomeInteractor {
    
    var output : HomeInteractorOutputProtocol?
    private let disposeBag = DisposeBag()
    
}

extension HomeInteractor : HomeInteractorProtocol {
    
    
    func fetchHorizontalProducts() {
        
        ProductServiceManager.shared.getHorizontalProduct()
            .subscribe { [weak self] suggestedProduct in
                self?.output?.fetchHorizontalProductsOutput(result: suggestedProduct[0].products)
            }onFailure: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
    func fetchVerticalProducts() {
        ProductServiceManager.shared.getVerticalProduct()
            .subscribe { [weak self] product in
                self?.output?.fetchVerticalProductsOutput(result: product[0].products)
            }onFailure: { error in
                print(error)
            }.disposed(by: disposeBag)
    }
    
}
