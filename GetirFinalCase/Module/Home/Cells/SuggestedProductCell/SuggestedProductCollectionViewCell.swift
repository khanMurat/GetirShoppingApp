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
    
    var cellPresenter : SuggestedProductCellPresenterProtocol! {
        didSet{
            cellPresenter.load()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        addSubview(productImageView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            productNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            
            productPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            productPriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            productPriceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 4),
            
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            productNameLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 4),
        
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
