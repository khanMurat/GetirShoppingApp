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
    func setProductPrice(_ price : Double)
    func setProductName(_ name : String)
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
        sv.layer.borderColor = UIColor.systemGray4.cgColor
        sv.layer.borderWidth = 0.5
        sv.layer.cornerRadius = 10
        sv.addArrangedSubview(productImageView)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let actionButtonAdd: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.tintColor = .systemPurple
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let productCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        lbl.textColor = .white
        lbl.text = "1"
        lbl.textAlignment = .center
        lbl.backgroundColor = .systemPurple
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let actionButtonRemove: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.tintColor = .systemPurple
        button.backgroundColor = .white
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.systemGray3.cgColor
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
    
    
    var suggestedCellPresenter : SuggestedProductCellPresenterProtocol! {
        didSet{
            suggestedCellPresenter.load()
        }
    }
    
    var cellPresenter : ProductCellPresenterProtocol! {
        didSet{
            cellPresenter.load()
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(stackView)
        addSubview(productNameLabel)
        addSubview(productPriceLabel)
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
        suggestedCellPresenter.addProductToBasket()
    }
    
    @objc private func handleActionRemoveButtonTap() {
        suggestedCellPresenter.removeProductFromBasket()
    }
    
    //MARK: - Helpers
    
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
            
            actionButtonAdd.topAnchor.constraint(equalTo: stackView.topAnchor,constant: -8),
            actionButtonAdd.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: 4),
            actionButtonAdd.widthAnchor.constraint(equalToConstant: 30),
            actionButtonAdd.heightAnchor.constraint(equalToConstant: 30),
            
            stackViewButtonAndLabel.topAnchor.constraint(equalTo: actionButtonAdd.bottomAnchor),
            stackViewButtonAndLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor,constant: -16),
            stackViewButtonAndLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: 4),
            stackViewButtonAndLabel.widthAnchor.constraint(equalToConstant: 30),
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
    
    func setProductPrice(_ price: Double) {
        print(price)
    }
    
    func setProductName(_ name: String) {
        self.productNameLabel.text = name
    }
    
    func setStackViewColorIfIsBasket(_ isBasket: Bool) {
        
        if isBasket {
            self.stackView.layer.borderColor = UIColor.systemPurple.cgColor
            self.stackView.layer.borderWidth = 1.0
            self.stackViewButtonAndLabel.isHidden = false
        }
        else{
            self.stackView.layer.borderColor = UIColor.systemGray5.cgColor
            self.stackView.layer.borderWidth = 0.3
            self.stackViewButtonAndLabel.isHidden = true
        }
    }
    
    func performAddToBasketAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.stackView.layer.borderColor = UIColor.systemPurple.cgColor
            self?.stackView.layer.borderWidth = 1.0
            self?.stackViewButtonAndLabel.isHidden = false
        }, completion: nil)
    }
    
    func performRemoveFromBasketAnimation(_ count : Int) {
        if count == 0 {
            UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseInOut], animations: { [weak self] in
                self?.stackView.layer.borderColor = UIColor.systemGray5.cgColor
                self?.stackView.layer.borderWidth = 1.0
                self?.stackViewButtonAndLabel.isHidden = true
            }, completion: nil)
        }
    }
    
    func setProductBasketCount(_ count: Int) {
        productCountLabel.text = String(count)
    }
}
