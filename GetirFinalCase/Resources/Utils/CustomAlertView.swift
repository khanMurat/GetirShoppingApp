//
//  CustomAlertView.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation
import UIKit

final class CustomAlertView : UIView {
    
    var didPressedNo: (() -> Void)?
    
    var didPressedYes: (() -> Void)?
    
    var isNoButtonHidden: Bool {
        get {
            return noButton.isHidden
        }
        set {
            noButton.isHidden = newValue
        }
    }
    
    let backgroundView : UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let noButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hayır", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .color_secondaryText
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let yesButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Evet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .color_purple
        button.layer.cornerRadius = 10
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

        addSubview(backgroundView)
        backgroundView.addSubview(containerView)
        
        
        let buttonStackView = UIStackView(arrangedSubviews: [noButton, yesButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(messageLabel)
        containerView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            containerView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            buttonStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
    }
    
    @objc func noButtonTapped() {
        didPressedNo?()
    }
    
    @objc func yesButtonTapped() {
        didPressedYes?()
    }
    
    func setYesButtonTitle(_ title: String) {
        yesButton.setTitle(title, for: .normal)
    }
}
