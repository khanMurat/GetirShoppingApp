//
//  DetailViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation
import UIKit


final class DetailViewController : BaseViewController {
    
    private let productImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = ._getirLogo
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let productPriceLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .color_purple
        lbl.text = "₺140,75"
        lbl.font = .systemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Fanta"
        lbl.font = .systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productAttributeLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "3X5"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textColor = .color_secondaryText
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let bottomTabView : UIView = {
        let view = UIView()
        view.backgroundColor = .color_lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let addToBasketButton: CustomAddButton = {
        let button = CustomAddButton(type: .custom)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    private let stepperView : CustomStepperView = {
       let view = CustomStepperView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [productNameLabel, productPriceLabel, productAttributeLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(productImageView)
        view.addSubview(stackView)
        view.addSubview(bottomTabView)
      
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor,constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 71)
        ])
        
        NSLayoutConstraint.activate([
            bottomTabView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomTabView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
        bottomTabView.addSubview(addToBasketButton)
        
        addToBasketButton.addTarget(self, action: #selector(didTapAddToBasket), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addToBasketButton.topAnchor.constraint(equalTo: bottomTabView.topAnchor, constant: 16),
            addToBasketButton.heightAnchor.constraint(equalToConstant: 50),
            addToBasketButton.leadingAnchor.constraint(equalTo: bottomTabView.leadingAnchor, constant: 16),
            addToBasketButton.trailingAnchor.constraint(equalTo: bottomTabView.trailingAnchor, constant: -16)
        ])
        
//        NSLayoutConstraint.activate([
//            stepperView.topAnchor.constraint(equalTo: bottomTabView.topAnchor, constant: 16),
//            stepperView.centerXAnchor.constraint(equalTo: bottomTabView.centerXAnchor),
//            stepperView.heightAnchor.constraint(equalToConstant: 48),
//            stepperView.widthAnchor.constraint(equalToConstant: 146),
//            
//        ])
    }
    
    @objc private func didTapAddToBasket() {
        addToBasketButton.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.addToBasketButton.hideLoading()
        }
    }
    
}
