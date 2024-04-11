//
//  ProductRepository.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import Foundation
import RealmSwift

protocol ProductRepositoryProtocol {
    func addToBasket(product: RealmProduct, completion: @escaping (Bool) -> Void)
    func removeFromBasket(productID:String,completion: @escaping (Bool,Int?) -> Void)
    func clearBasket(completion: @escaping (Bool) -> Void)
    func checkIfProductInBasket(productID:String) -> Bool
    func checkProductBasketCount(productID:String) -> Int
    func getAllBasketItems() -> [RealmProduct]
}

final class ProductRepository {
    
    static let shared = ProductRepository()
    
    let realm = try? Realm()
    
}

extension ProductRepository : ProductRepositoryProtocol {
    
    func addToBasket(product: RealmProduct, completion: @escaping (Bool) -> Void) {
        guard let realm = realm else {
            completion(false)
            return
        }
        
        do {
            try realm.write {
                let existingProduct = realm.object(ofType: RealmProduct.self, forPrimaryKey: product.id)
                
                if let existingProduct = existingProduct {
                    existingProduct.isBasket = true
                    existingProduct.basketCount += 1
                } else {
                    product.isBasket = true
                    product.basketCount = 1
                    realm.add(product)
                }
                completion(true)
            }
        } catch let error {
            print("Error adding product to basket: \(error)")
            completion(false)
        }
    }
    
    
    func removeFromBasket(productID: String, completion: @escaping (Bool,Int?) -> Void) {
        guard let realm = realm, let product = realm.object(ofType: RealmProduct.self, forPrimaryKey: productID) else {
            completion(false,nil)
            return
        }
        do {
            try realm.write {
                if product.basketCount > 0 {
                    product.basketCount -= 1
                    if product.basketCount == 0 {
                        product.isBasket = false
                    }
                }
                completion(true,product.basketCount)
            }
        } catch {
            print("Error removing product from basket: \(error)")
            completion(false,nil)
        }
    }
    
    func clearBasket(completion: @escaping (Bool) -> Void) {
        let basketProducts = realm?.objects(RealmProduct.self).filter("isBasket == true")
        
        do {
            try realm?.write {
                basketProducts?.forEach { product in
                    product.isBasket = false
                    product.basketCount = 0
                    completion(true)
                }
            }
        }catch {
            print("Error removing products from basket: \(error)")
            completion(false)
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

