//
//  ProductServiceManager.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation
import Moya
import RxMoya
import RxSwift

enum NetworkError : Error {
    case invalidURL
    case noData
    case parsingError
    case unknown
    
    var title : String {
        switch self {
        case .invalidURL:
            return "Invalid URL!"
        case .noData:
            return "There is no result!"
        case .parsingError:
            return "Error occured when try to parse data!"
        case .unknown:
            return "There is an unknown error"
        }
    }
}

struct ProductServiceManager {
    
    static let shared = ProductServiceManager()
    
    private let provider = MoyaProvider<ProductService>()
    
    func getVerticalProduct() -> Single<[ProductCategory]> {
        
        return provider.rx
            .request(.getVerticalProduct)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([ProductCategory].self)
    }
    
    func getHorizontalProduct() -> Single<[SuggestedProductsResponse]> {
        
        return provider.rx
            .request(.getHorizontalProduct)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([SuggestedProductsResponse].self)
    }
}
