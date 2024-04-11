//
//  ProductRepository.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import Foundation
import RealmSwift

protocol ProductRepositoryProtocol {
    func addToBasket(productID:String)
    func removeFromBasket(productID:String)
    func clearBasket()
    func checkIfProductInBasket(productID:String) -> Bool
    func checkProductBasketCount(productID:String) -> Int
    func getAllBasketItems() -> [RealmProduct]
}

final class ProductRepository {
    
    static let shared = ProductRepository()
    
    let realm = try? Realm()
    
}

extension ProductRepository : ProductRepositoryProtocol {
    
    func addToBasket(productID: String) {
        guard let product = realm?.object(ofType: RealmProduct.self, forPrimaryKey: productID) else { return }
        try! realm?.write {
            product.isBasket = true
            product.basketCount += 1
        }
    }
    
    func removeFromBasket(productID: String) {
        guard let product = realm?.object(ofType: RealmProduct.self, forPrimaryKey: productID) else { return }
        try! realm?.write {
            if product.basketCount > 0 {
                product.basketCount -= 1
                if product.basketCount == 0 {
                    product.isBasket = false
                }
            }
        }
    }
    
    func clearBasket() {
        let basketProducts = realm?.objects(RealmProduct.self).filter("isBasket == true")
        try! realm?.write {
            basketProducts?.forEach { product in
                product.isBasket = false
                product.basketCount = 0
            }
        }
    }
    
    func checkIfProductInBasket(productID: String) -> Bool {
        guard let product = realm?.object(ofType: RealmProduct.self, forPrimaryKey: productID) else { return false }
        return product.isBasket
    }
    
    func checkProductBasketCount(productID:String) -> Int {
        
        if checkIfProductInBasket(productID: productID) {
            guard let product = realm?.object(ofType: RealmProduct.self, forPrimaryKey: productID) else { return 0 }
            return product.basketCount
        }else{
            return 0
        }
    }
    
    func getAllBasketItems() -> [RealmProduct] {
        let basketItems = realm?.objects(RealmProduct.self).filter("isBasket == true")
        return basketItems?.compactMap({ $0 }) ?? []
    }
}

