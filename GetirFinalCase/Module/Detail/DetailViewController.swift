//
//  DetailViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation
import UIKit

protocol DetailViewControllerProtocol : AnyObject {
    func setProductImage(_ image : String)
    func setProductPrice(_ price : String)
    func setProductName(_ name : String)
    func setProductAttribute(_ name : String)
    func setupView()
    func setupActions()
    func setTitle(_ title: String)
    func setupBarButtonItem(_ totalPrice : Double)
    func setupBottomView(_ isBasket : Bool)
    func setupStepperValue(_ count : Int)
    func showLeftBarButton()
}

final class DetailViewController : BaseViewController {
    
    //MARK: - Properties
    
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
        lbl.font = .sansBold20
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = .sansSemiBold16
        lbl.numberOfLines = 0
        lbl.textColor = .color_textDark
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productAttributeLabel : UILabel = {
        let lbl = UILabel()
        lbl.font = .sansSemiBold12
        lbl.textColor = .color_secondaryText
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let bottomTabView : CustomTabView = {
        let view = CustomTabView()
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
    
    var presenter : DetailPresenterProtocol!
    
    let basketView = BasketView()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewdidLoad()
    }
    
    deinit {
        presenter.removeNotifications()
    }
    
    //MARK: - Helpers
    
    func setupView() {
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
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor,constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 87),
            
            bottomTabView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomTabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomTabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomTabView.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    func setupActions() {
        
        addToBasketButton.addTarget(self, action: #selector(didTapAddToBasket), for: .touchUpInside)
        
        stepperView.didIncrease = {[weak self] in
            self?.presenter.addProductToBasket()
        }
        
        stepperView.didDecrease = {[weak self] in
            self?.presenter.removeProductFromBasket()
        }
    }
    
    //MARK: - Actions
    
    @objc func handleDissmiss(){
        self.dismiss(animated: true)
    }
    
    @objc private func didTapAddToBasket() {
        addToBasketButton.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.presenter.addProductToBasket()
            self.addToBasketButton.hideLoading()
        }
    }
}

//MARK: - DetailViewControllerProtocol

extension DetailViewController : DetailViewControllerProtocol {
    
    func setProductImage(_ image: String) {
        self.productImageView.fetchImage(image, ._placeholder)
    }
    
    func setProductPrice(_ price: String) {
        self.productPriceLabel.text = price
    }
    
    func setProductName(_ name: String) {
        self.productNameLabel.text = name
    }
    
    func setProductAttribute(_ name: String) {
        self.productAttributeLabel.text = name
    }
    
    func setupBarButtonItem(_ totalPrice: Double) {
        
        basketView.setTotalPrice(totalPrice)
        basketView.onBasketTapped = {
            self.presenter.tappedBasket()
        }
        let basketButtonItem = UIBarButtonItem(customView: basketView)
        navigationItem.rightBarButtonItem = basketButtonItem
        
        if totalPrice > 0 {
            basketView.widthAnchor.constraint(equalToConstant: 91).isActive = true
            basketView.heightAnchor.constraint(equalToConstant: 34).isActive = true
            self.showBarButtonItemWithAnimation(basketView: basketView)
        } else {
            hideBarButtonItemWithAnimation(basketView: basketView)
        }
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setupBottomView(_ isBasket: Bool) {
        
        addToBasketButton.removeFromSuperview()
        stepperView.removeFromSuperview()
        
        if isBasket {
            bottomTabView.addSubview(stepperView)
            NSLayoutConstraint.activate([
                stepperView.topAnchor.constraint(equalTo: bottomTabView.topAnchor, constant: 16),
                stepperView.centerXAnchor.constraint(equalTo: bottomTabView.centerXAnchor),
                stepperView.heightAnchor.constraint(equalToConstant: 48),
                stepperView.widthAnchor.constraint(equalToConstant: 146)
            ])
        } else {
            bottomTabView.addSubview(addToBasketButton)
            NSLayoutConstraint.activate([
                addToBasketButton.topAnchor.constraint(equalTo: bottomTabView.topAnchor, constant: 16),
                addToBasketButton.heightAnchor.constraint(equalToConstant: 50),
                addToBasketButton.leadingAnchor.constraint(equalTo: bottomTabView.leadingAnchor, constant: 16),
                addToBasketButton.trailingAnchor.constraint(equalTo: bottomTabView.trailingAnchor, constant: -16)
            ])
        }
    }
    
    func setupStepperValue(_ count: Int) {
        self.stepperView.productCount = count
    }
    
    func showLeftBarButton() {
        self.showDismissBarButton()
    }
}
