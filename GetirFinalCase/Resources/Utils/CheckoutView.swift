//
//  CheckoutView.swift
//  GetirFinalCase
//
//  Created by Murat on 15.04.2024.
//


import UIKit

final class CheckoutView : UIView {
    
    var didPressCheckoutButton: (() -> Void)?
    
    var totalPrice: Double = 0 {
        didSet {
            totalAmountLabel.text = String(format: "₺%.2f", totalPrice)
        }
    }
        
    private let checkOutButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .color_purple
        button.setTitle("Siparişi Tamamla", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleCheckoutButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let totalAmountLabel : UILabel = {
      let lbl = UILabel()
        lbl.font = .sansBold20
        lbl.text = "290"
        lbl.textColor = .color_purple
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let amountView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        
    }
    
    @objc private func handleCheckoutButton(){
        didPressCheckoutButton?()
    }
    
    private func setupView(){
        
        addSubview(checkOutButton)
        addSubview(amountView)
        amountView.addSubview(totalAmountLabel)
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.color_lightGray.cgColor
        
        NSLayoutConstraint.activate([
            
            checkOutButton.topAnchor.constraint(equalTo: topAnchor),
            checkOutButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkOutButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkOutButton.widthAnchor.constraint(equalToConstant: 250),
            
            amountView.topAnchor.constraint(equalTo: topAnchor),
            amountView.trailingAnchor.constraint(equalTo: trailingAnchor),
            amountView.leadingAnchor.constraint(equalTo: checkOutButton.trailingAnchor,constant: -4),
            amountView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            totalAmountLabel.centerXAnchor.constraint(equalTo: amountView.centerXAnchor),
            totalAmountLabel.centerYAnchor.constraint(equalTo: amountView.centerYAnchor),
        ])
    }
}
