//
//  BasketInteractor.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation

protocol BasketInteractorProtocol : AnyObject {
    
}

protocol BasketInteractorOutputProtocol : AnyObject {
    
}

final class BasketInteractor {
    
    var output : BasketInteractorOutputProtocol?
    
}


extension BasketInteractor : BasketInteractorProtocol {
    
}
