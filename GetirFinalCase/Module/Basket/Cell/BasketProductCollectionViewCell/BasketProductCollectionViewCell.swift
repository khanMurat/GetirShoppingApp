//
//  BasketProductCollectionViewCell.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation
import UIKit

final class BasketProductCollectionViewCell : UICollectionViewCell {
    
    
    //MARK: - Properties
    
    private let productImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "getir-logo")
        iv.layer.cornerRadius = 16
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.color_secondaryText.cgColor
        return iv
    }()
    
    private let productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        lbl.text = "Name"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.text = "14,35"
        lbl.textColor = UIColor.color_purple
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productAttributeLabel : UILabel = {
       let lbl = UILabel()
        lbl.textColor = .color_lightGray
        lbl.text = "3x5"
        lbl.font = .systemFont(ofSize: 12, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var stackViewProductInformation : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.productNameLabel, self.productPriceLabel, self.productAttributeLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stepperView : CustomStepperView = {
       let stepper = CustomStepperView()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    private var horizontalContainerView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white

        addSubview(horizontalContainerView)
        horizontalContainerView.addSubview(productImageView)
        horizontalContainerView.addSubview(stackViewProductInformation)
        horizontalContainerView.addSubview(stepperView)
        
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
            horizontalContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
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
            stepperView.trailingAnchor.constraint(equalTo: horizontalContainerView.trailingAnchor)
            
        ])
        
    }
}
