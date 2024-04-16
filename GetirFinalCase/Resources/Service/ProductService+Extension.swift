//
//  ProductService+Extension.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation
import Moya

extension ProductService : TargetType {
    
    var baseURL: URL {
        return URL(string:"https://65c38b5339055e7482c12050.mockapi.io/api")!
    }
    
    var path: String {
        
        switch self {
            
        case .getVerticalProduct:
            return "/products"
            
        case .getHorizontalProduct:
            return "/suggestedProducts"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
}
