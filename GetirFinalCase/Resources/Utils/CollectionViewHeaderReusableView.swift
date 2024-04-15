//
//  CollectionViewHeaderReusableView.swift
//  GetirFinalCase
//
//  Created by Murat on 11.04.2024.
//

import Foundation
import UIKit

final class CollectionViewHeaderReusableView: UICollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .color_purple
        label.font = .sansSemiBold12
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray6
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16)
        ])
    }
    
    func setTitle(_ text: String?) {
        titleLabel.text = text
    }
}

