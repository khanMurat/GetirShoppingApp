//
//  HomeInteractor.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation

protocol HomeInteractorProtocol : AnyObject {
    func fetchProducts()
}

protocol HomeInteractorOutputProtocol : AnyObject {
    func fetchProductsOutput(result : [Product])
}

final class HomeInteractor {
    
    var output : HomeInteractorOutputProtocol?
    
    
}

extension HomeInteractor : HomeInteractorProtocol {
    func fetchProducts() {
        
        self.output?.fetchProductsOutput(result: []) // backenddedn çektiğimiz productları göndereceğiz !
        
    }
}
