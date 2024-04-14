//
//  CustomStepperView.swift
//  GetirFinalCase
//
//  Created by Murat on 12.04.2024.
//

import Foundation
import UIKit


class CustomStepperView : UIView {
    
    var didIncrease: (() -> Void)?
    
    var didDecrease: (() -> Void)?
    
    var productCount: Int = 1 {
        didSet {
            counterLabel.text = "\(productCount)"
        }
    }
    
    private let decreaseButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(._trash?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let counterView : UIView = {
       let view = UIView()
        view.backgroundColor = .color_purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let counterLabel : UILabel = {
       let lbl = UILabel()
        lbl.text = "1"
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let increaseButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(._plusm?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupLayout()
        setupActions()
     }
    
    private func setupLayout() {

        let stackView = UIStackView(arrangedSubviews: [decreaseButton, counterView, increaseButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.color_lightGray.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        counterView.addSubview(counterLabel)
        
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: counterView.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: counterView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupActions() {
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
    }
    
    @objc private func decreaseButtonTapped() {
        didDecrease?()
    }

    @objc private func increaseButtonTapped() {
        didIncrease?()
    }
}
