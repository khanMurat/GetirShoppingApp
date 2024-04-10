//
//  SuggestedProductCollectionViewCell.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import UIKit

protocol SuggestedProductProtocol : AnyObject {
    
    func setProductImage(_ imageName : String?)
    func setSquareThumbnailImage(_ imageName : String?)
    func setProductPriceText(_ priceText : String)
    func setProductPrice(_ price : Double)
    func setProductName(_ name : String)
}

final class SuggestedProductCollectionViewCell: UICollectionViewCell {
        
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.image = ._getirLogo
        return iv
    }()
    
    private let productNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        lbl.textColor = .systemPurple
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var stackView : UIStackView = {
       let sv = UIStackView()
        sv.distribution = .fill
        sv.layer.borderColor = UIColor.systemGray5.cgColor
        sv.layer.borderWidth = 0.3
        sv.layer.cornerRadius = 10
        sv.addArrangedSubview(productImageView)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cellPresenter : SuggestedProductCellPresenterProtocol! {
        didSet{
            cellPresenter.load()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        addSubview(stackView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(actionButton)
        
        actionButton.addTarget(self, action: #selector(handleActionButtonTap), for: .touchUpInside)
        
        setupConstraints()
    }
    
    @objc private func handleActionButtonTap() {
        UIView.animate(withDuration: 2.0) { [weak self] in
            self?.stackView.layer.borderColor = UIColor.systemPurple.cgColor
            self?.stackView.layer.borderWidth = 0.7
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            productPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            productPriceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            productNameLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 4),
            
            actionButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            actionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 30),
            actionButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SuggestedProductCollectionViewCell : SuggestedProductProtocol {
    
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
    
    func setProductPrice(_ price: Double) {
        print(price)
    }
    
    func setProductName(_ name: String) {
        self.productNameLabel.text = name
    }
}
