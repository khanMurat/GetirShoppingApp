//
//  SuggestedProductCollectionViewCell.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import UIKit

protocol ProductProtocol : AnyObject {
    
    func setProductImage(_ imageName : String?)
    func setSquareThumbnailImage(_ imageName : String?)
    func setProductPriceText(_ priceText : String)
    func setProductName(_ name : String)
    func setProductAttribute(_ name : String)
    func setStackViewColorIfIsBasket(_ isBasket : Bool)
    func performAddToBasketAnimation()
    func performRemoveFromBasketAnimation(_ count : Int)
    func setProductBasketCount(_ count: Int)
}

final class ProductCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let productPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 14, weight: .semibold)
        lbl.textColor = UIColor.color_purple
        lbl.font = .sansBold14
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 2
        lbl.font = .sansSemiBold12
        lbl.textColor = .color_textDark
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
        
    private let productAttributeLabel : UILabel = {
       let lbl = UILabel()
        lbl.textColor = .color_secondaryText
        lbl.font = .sansSemiBold12
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var stackView : UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fill
        sv.layer.borderColor = UIColor.color_lightGray.cgColor
        sv.layer.borderWidth = 1
        sv.layer.cornerRadius = 16
        sv.addArrangedSubview(productImageView)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let actionButtonAdd: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setImage(._plusm?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.color_lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let productCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .semibold)
        lbl.textColor = .white
        lbl.text = "1"
        lbl.font = .sansBold12
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor.color_purple
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let actionButtonRemove: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(._trash?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.color_lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackViewButtonAndLabel : UIStackView = {
        let sv = UIStackView()
        sv.distribution = .fillEqually
        sv.spacing = 0
        sv.axis = .vertical
        sv.addArrangedSubview(productCountLabel)
        sv.addArrangedSubview(actionButtonRemove)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    var actionDelegate: ProductActionProtocol? {
        didSet {
            actionDelegate?.load()
        }
    }
    
    var suggestedCellPresenter : SuggestedProductCellPresenterProtocol! {
        didSet{
            actionDelegate = suggestedCellPresenter
        }
    }
    
    var cellPresenter : ProductCellPresenterProtocol! {
        didSet{
            actionDelegate = cellPresenter
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(stackView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
        addSubview(productAttributeLabel)
        addSubview(actionButtonAdd)
        addSubview(stackViewButtonAndLabel)
        
        stackViewButtonAndLabel.isHidden = true
        
        actionButtonAdd.addTarget(self, action: #selector(handleActionButtonTap), for: .touchUpInside)
        actionButtonRemove.addTarget(self, action: #selector(handleActionRemoveButtonTap), for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc private func handleActionButtonTap() {
        actionDelegate?.addProductToBasket()
    }
    
    @objc private func handleActionRemoveButtonTap() {
        actionDelegate?.removeProductFromBasket()
    }
    
    //MARK: - Helpers
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            stackView.heightAnchor.constraint(equalToConstant: 104),
            
            productPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            productPriceLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            productNameLabel.topAnchor.constraint(equalTo: productPriceLabel.bottomAnchor, constant: 4),
            
            productAttributeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            productAttributeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4),
            productAttributeLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            
            actionButtonAdd.topAnchor.constraint(equalTo: stackView.topAnchor,constant: -8),
            actionButtonAdd.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: 4),
            actionButtonAdd.widthAnchor.constraint(equalToConstant: 32),
            actionButtonAdd.heightAnchor.constraint(equalToConstant: 32),
            
            stackViewButtonAndLabel.topAnchor.constraint(equalTo: actionButtonAdd.bottomAnchor,constant: -4),
            stackViewButtonAndLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor,constant: -12),
            stackViewButtonAndLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: 4),
            stackViewButtonAndLabel.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
}

//MARK: - Configuration

extension ProductCollectionViewCell : ProductProtocol {
    
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
    
    
    func setProductName(_ name: String) {
        self.productNameLabel.text = name
    }
    
    func setProductAttribute(_ name: String) {
        self.productAttributeLabel.text = name
    }
    
    func setStackViewColorIfIsBasket(_ isBasket: Bool) {
        
        if isBasket {
            self.stackView.layer.borderColor = UIColor.color_purple.cgColor
            self.stackView.layer.borderWidth = 1.5
            self.stackViewButtonAndLabel.isHidden = false
        }
        else{
            self.stackView.layer.borderColor = UIColor.color_lightGray.cgColor
            self.stackView.layer.borderWidth = 1
            self.stackViewButtonAndLabel.isHidden = true
        }
    }
    
    func performAddToBasketAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.stackView.layer.borderColor = UIColor.color_purple.cgColor
            self?.stackView.layer.borderWidth = 1.5
            self?.stackViewButtonAndLabel.isHidden = false
        }, completion: nil)
    }
    
    func performRemoveFromBasketAnimation(_ count : Int) {
        if count == 0 {
            UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseInOut], animations: { [weak self] in
                self?.stackView.layer.borderColor = UIColor.color_lightGray.cgColor
                self?.stackView.layer.borderWidth = 1
                self?.stackViewButtonAndLabel.isHidden = true
            }, completion: nil)
        }
    }
    
    func setProductBasketCount(_ count: Int) {
        productCountLabel.text = String(count)
    }
}
