//
//  CustomTabView.swift
//  GetirFinalCase
//
//  Created by Murat on 14.04.2024.
//

import Foundation
import UIKit

final class CustomTabView : UIView {
    
    private let bottomTabView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.color_secondaryText.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
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
    
    private func setupView(){
        
        addSubview(bottomTabView)
        
        NSLayoutConstraint.activate([
            bottomTabView.topAnchor.constraint(equalTo: topAnchor),
            bottomTabView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomTabView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomTabView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
