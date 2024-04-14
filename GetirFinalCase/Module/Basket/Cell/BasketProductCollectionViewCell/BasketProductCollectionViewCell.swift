//
//  BasketProductCollectionViewCell.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation
import UIKit

protocol BasketProductProtocol : AnyObject {
    
    func setProductImage(_ imageName : String?)
    func setSquareThumbnailImage(_ imageName : String?)
    func setProductPriceText(_ priceText : String)
    func setProductName(_ name : String)
    func setProductAttribute(_ name : String)
}

final class BasketProductCollectionViewCell : UICollectionViewCell {
    
    //MARK: - Properties
    
    private let productImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "getir-logo")
        iv.layer.cornerRadius = 16
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.color_lightGray.cgColor
        return iv
    }()
    
    private let productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .sansSemiBold12
        lbl.numberOfLines = 2
        lbl.textColor = .color_textDark
        lbl.text = "Name"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productAttributeLabel : UILabel = {
       let lbl = UILabel()
        lbl.textColor = .color_secondaryText
        lbl.text = "3x5"
        lbl.font = .sansSemiBold12
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .sansBold14
        lbl.text = "14,35"
        lbl.textColor = UIColor.color_purple
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
        
    private lazy var stackViewProductInformation : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.productNameLabel, self.productAttributeLabel,self.productPriceLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stepperView : CustomStepperView = {
       let stepper = CustomStepperView()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    private let horizontalContainerView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let seperatorView : UIView = {
       let view = UIView()
        view.backgroundColor = .color_lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cellPresenter : BasketProductCellPresenterProtocol! {
        didSet{
            cellPresenter.load()
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        addSubview(horizontalContainerView)
        horizontalContainerView.addSubview(productImageView)
        horizontalContainerView.addSubview(stackViewProductInformation)
        horizontalContainerView.addSubview(stepperView)
        addSubview(seperatorView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
        
            horizontalContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            horizontalContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            horizontalContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
            
            productImageView.leadingAnchor.constraint(equalTo: horizontalContainerView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: horizontalContainerView.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: horizontalContainerView.bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 74),
            
            stackViewProductInformation.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor,constant: 8),
            stackViewProductInformation.centerYAnchor.constraint(equalTo: horizontalContainerView.centerYAnchor),
            stackViewProductInformation.heightAnchor.constraint(equalToConstant: 57),
            stackViewProductInformation.widthAnchor.constraint(equalToConstant: 143),
            
            stepperView.leadingAnchor.constraint(equalTo: stackViewProductInformation.trailingAnchor, constant: 8),
            stepperView.centerYAnchor.constraint(equalTo: horizontalContainerView.centerYAnchor),
            stepperView.heightAnchor.constraint(equalToConstant: 32),
            stepperView.trailingAnchor.constraint(equalTo: horizontalContainerView.trailingAnchor),
            
            seperatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 1),
            seperatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
}

extension BasketProductCollectionViewCell : BasketProductProtocol {
    
    func setProductImage(_ imageName: String?) {
        if let imageName = imageName {
            productImageView.fetchImage(imageName, ._placeholder)
        }
    }
    
    func setSquareThumbnailImage(_ imageName: String?) {
        
        if let imageName = imageName {
            productImageView.fetchImage(imageName, ._placeholder)
        }
    }
    
    func setProductPriceText(_ priceText: String) {
        
        self.productPriceLabel.text = priceText
    }
    
    func setProductName(_ name: String) {
        
        self.productNameLabel.text = name
    }
    
    func setProductAttribute(_ name: String) {
        self.productAttributeLabel.text = name
    }
    
    
    
}
