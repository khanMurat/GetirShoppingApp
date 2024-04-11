////
////  SuggestedProductCellInteractor.swift
////  GetirFinalCase
////
////  Created by Murat on 11.04.2024.
////
//
//import Foundation
//
//protocol SuggestedProductCellInteractorProtocol : AnyObject {
//    func checkProductInBasket(productID:String)
//    func addProductToBasket(productID:String)
//    func removeProductFromBasket(productID:String)
//    func checkProductCount(productID:String)
//}
//
//protocol SuggestedProductCellInteractorOutputProtocol : AnyObject {
//    
//    func checkProductInBasketOutput(result:Bool)
//    
//    func addProductToBasketOutput(result:Bool)
//    
//    func removeProductFromBasketOutput(result:Bool)
//    
//    func checkProductCount(result:Int)
//    
//    
//}
//
//final class SuggestedProductCellInteractor {
//    
//    var output : SuggestedProductCellInteractorOutputProtocol?
//    
//}
//
//extension SuggestedProductCellInteractor : SuggestedProductCellInteractorProtocol {
//    
//    func checkProductInBasket(productID: String){
//        self.output?.checkProductInBasketOutput(result: ProductRepository.shared.checkIfProductInBasket(productID: productID))
//    }
//    
//    func addProductToBasket(productID: String) {
//        
//        ProductRepository.shared.addToBasket(productID: productID) {[weak self] success in
//            
//            guard let self else {return}
//            
//            if success {
//                self.output?.addProductToBasketOutput(result: success)
//                NotificationCenter.default.post(name: .productAddedToBasket, object: nil, userInfo: ["productID": productID])
//            }
//        }
//    }
//    
//    func removeProductFromBasket(productID: String) {
//        
//        ProductRepository.shared.removeFromBasket(productID: productID) {[weak self] success in
//            guard let self else {return}
//            
//            if success {
//                self.output?.removeProductFromBasketOutput(result: success)
//                NotificationCenter.default.post(name: .productRemovedFromBasket, object: nil, userInfo: ["productID": productID])
//            }
//        }
//    }
//    
//    func checkProductCount(productID: String) {
//        
//        self.output?.checkProductCount(result: ProductRepository.shared.checkProductBasketCount(productID: productID))
//    }
//
//}
