//
//  SplashInteractor.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation


protocol SplashInteractorProtocol : AnyObject {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol : AnyObject {
    func internetConnection(status:Bool)
}



final class SplashInteractor {
    
    var output : SplashInteractorOutputProtocol?
    
}


extension SplashInteractor : SplashInteractorProtocol {
    func checkInternetConnection() {
        
        var internetStatus = true
        
        if Reachability.isConnectedToNetwork() == false {
            internetStatus = false
        }else{
            internetStatus = true
        }
        
        self.output?.internetConnection(status: internetStatus)
    }
    
}
