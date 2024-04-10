//
//  HomeEntitiy.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation

struct ProductCategory: Decodable {
    let id: String
    let name: String
    let productCount: Int
    let products: [Product]
}

struct Product: Decodable {
    let id: String?
    let name: String?
    let attribute: String?
    let thumbnailURL: String?
    let imageURL: String?
    let price: Double?
    let priceText: String?
    let shortDescription: String?
    
}

struct SuggestedProductsResponse: Decodable {
    let products: [SuggestedProduct]
    let id: String
    let name: String
}

struct SuggestedProduct: Decodable {
    let id: String?
    let imageURL: String?
    let price: Double?
    let name: String?
    let priceText: String?
    let shortDescription: String?
    let category: String?
    let unitPrice: Double?
    let squareThumbnailURL: String?
    let status: Int?
    
}


