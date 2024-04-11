//
//  SplashPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import Foundation

protocol SplashPresenterProtocol : AnyObject {
    func viewDidAppear()
}


final class SplashPresenter : SplashPresenterProtocol {
    
    unowned var view : SplashViewControllerProtocol!
    let router : SplashRouterProtocol!
    let interactor : SplashInteractorProtocol!
    
    init(view: SplashViewControllerProtocol, router: SplashRouterProtocol, interactor: SplashInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidAppear() {
        
        view.setupView()
        
        view.setupConstraints()
        
        interactor.checkInternetConnection()
        
    }
    
}

extension SplashPresenter : SplashInteractorOutputProtocol {
    func internetConnection(status: Bool) {
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard let self else {return}
                self.router.navigate(.homeView)
            }
        }else{
            view.noInternetConnection()
        }
    }
    
}
