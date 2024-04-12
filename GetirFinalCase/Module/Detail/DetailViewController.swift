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
        }
    
}
