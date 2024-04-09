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
    let thumbnailURL: URL?
    let imageURL: URL?
    let price: Double?
    let priceText: String?
    let shortDescription: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, attribute, thumbnailURL, imageURL, price, priceText, shortDescription
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        attribute = try container.decodeIfPresent(String.self, forKey: .attribute)
        thumbnailURL = try container.decode(URL.self, forKey: .thumbnailURL)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        price = try container.decode(Double.self, forKey: .price)
        priceText = try container.decode(String.self, forKey: .priceText)
        shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription)
    }
}

struct SuggestedProductsResponse: Decodable {
    let products: [SuggestedProduct]
    let id: String
    let name: String
}

struct SuggestedProduct: Decodable {
    let id: String?
    let imageURL: URL?
    let price: Double?
    let name: String?
    let priceText: String?
    let shortDescription: String?
    let category: String?
    let unitPrice: Double?
    let squareThumbnailURL: URL?
    let status: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, imageURL, price, name, priceText, shortDescription, category, unitPrice, squareThumbnailURL, status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        price = try container.decode(Double.self, forKey: .price)
        name = try container.decode(String.self, forKey: .name)
        priceText = try container.decode(String.self, forKey: .priceText)
        shortDescription = try container.decodeIfPresent(String.self, forKey: .shortDescription)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        unitPrice = try container.decodeIfPresent(Double.self, forKey: .unitPrice)
        squareThumbnailURL = try container.decodeIfPresent(URL.self, forKey: .squareThumbnailURL)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
    }
}


