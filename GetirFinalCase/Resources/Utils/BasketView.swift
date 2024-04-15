//
//  BasketView.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation
import UIKit

final class BasketView : UIView {
    
    var onBasketTapped: (() -> Void)?
    
    let basketImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = ._basket
        return iv
    }()
    
    let backgroundTitleView : UIView = {
       let view = UIView()
        view.backgroundColor = .color_lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let totalPriceLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "1,00"
        lbl.textColor = .color_purple
        lbl.numberOfLines = 1
        lbl.font = .sansBold12
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupTapGesture()
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
       
        
        addSubview(basketImageView)
        addSubview(backgroundTitleView)
        backgroundTitleView.addSubview(totalPriceLabel)
        
        NSLayoutConstraint.activate([
            basketImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            basketImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            basketImageView.widthAnchor.constraint(equalToConstant: 34),
            basketImageView.heightAnchor.constraint(equalToConstant: 34),
            
            backgroundTitleView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundTitleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundTitleView.leadingAnchor.constraint(equalTo: basketImageView.trailingAnchor),
            backgroundTitleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundTitleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            totalPriceLabel.centerYAnchor.constraint(equalTo: backgroundTitleView.centerYAnchor)
        ])
    }
    
    private func setupTapGesture() {
            self.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(basketTappedAction))
            self.addGestureRecognizer(tapGesture)
        }
    
    @objc private func basketTappedAction() {
        onBasketTapped?()
    }
    
    func setTotalPrice(_ price: Double) {
        totalPriceLabel.text = String(format: "₺%.2f", price)
    }
}

