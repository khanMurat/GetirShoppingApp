//
//  BaseViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import UIKit

class BaseViewController: UIViewController,LoadingShowable {
    
    //MARK: - Properties
    
    var customAlertView: CustomAlertView?
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navBarStyle()
    }
    
    
    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in}
        
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    

    func showBarButtonItemWithAnimation(basketView:BasketView) {
        guard let basketView = self.navigationItem.rightBarButtonItem?.customView else { return }
        
        basketView.transform = CGAffineTransform(translationX: basketView.frame.width, y: 0)
        basketView.alpha = 0
        
        UIView.animate(withDuration: 0.7, animations: {
            basketView.transform = .identity
            basketView.alpha = 1
        })
    }
    
    func hideBarButtonItemWithAnimation(basketView:BasketView) {
        guard let basketView = self.navigationItem.rightBarButtonItem?.customView else { return }
        
        UIView.animate(withDuration: 0.7, animations: {
            basketView.transform = CGAffineTransform(translationX: basketView.frame.width, y: 0)
            basketView.alpha = 0
        }) { _ in
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func navBarStyle(){
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .color_purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.title = "Ürünler"
    }
    
    func presentCustomAlert(message: String,noAction: (() -> Void)? = nil, yesAction: (() -> Void)? = nil) {
        let alertView = CustomAlertView()
        alertView.messageLabel.text = message
        
        
        alertView.didPressedNo = {
            noAction?()
            self.dismissCustomAlert()
        }
        
        alertView.didPressedYes = {
            yesAction?()
            self.dismissCustomAlert()
        }
        
        self.customAlertView = alertView
        self.view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(equalTo: self.view.topAnchor),
            alertView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            alertView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        alertView.alpha = 0
        alertView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        UIView.animate(withDuration: 0.5) {
            alertView.alpha = 1
            alertView.transform = CGAffineTransform.identity
        }
    }
    
    func dismissCustomAlert() {
        DispatchQueue.main.async {
            guard let alertView = self.customAlertView else { return }
            
            UIView.animate(withDuration: 0.5, animations: {
                alertView.alpha = 0
            }, completion: { _ in
                alertView.removeFromSuperview()
            })
        }
    }
}
