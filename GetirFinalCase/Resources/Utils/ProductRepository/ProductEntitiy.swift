//
//  ProductEntitiy.swift
//  GetirFinalCase
//
//  Created by Murat on 11.04.2024.
//

import Foundation
import RealmSwift

class RealmProduct: Object {
    @Persisted var id: String = ""
    @Persisted var name: String = ""
    @Persisted var attribute: String?
    @Persisted var thumbnailURL: String?
    @Persisted var imageURL: String?
    @Persisted var price: Double = 0.0
    @Persisted var priceText: String?
    @Persisted var shortDescription: String?
    @Persisted var category: String?
    @Persisted var unitPrice: Double?
    @Persisted var squareThumbnailURL: String?
    @Persisted var status: Int?
    @Persisted var isBasket: Bool = false
    @Persisted var basketCount: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
