//
//  SplashViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import UIKit

protocol SplashViewControllerProtocol : AnyObject {
    
    func noInternetConnection()
    func setupView()
    func setupConstraints()
}

final class SplashViewController: BaseViewController {
    
    //MARK: - Properties
    
    let logoImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage._getirLogo
        return iv
    }()
    
    var presenter : SplashPresenterProtocol!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidAppear()
    }
}

//MARK: - SplashViewControllerProtocol

extension SplashViewController : SplashViewControllerProtocol {
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        
    }
    
    func setupConstraints(){
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func noInternetConnection() {
        self.showAlert(title: "Error", message: "No internet connection!")
        
    }
}
