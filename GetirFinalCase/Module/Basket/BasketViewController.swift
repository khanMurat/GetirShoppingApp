//
//  BasketViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import UIKit

protocol BasketViewControllerProtocol : AnyObject {
    func reloadData()
    func setupViews()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
    func showLeftBarButton()
    func showRightBarButton()
    func setupCheckoutView(_ totalPrice: Double)
    func checkBasketIsEmpty()
    func showError(_ message:String)
}

final class BasketViewController : BaseViewController {
    
    //MARK: - Properties
    
    var presenter : BasketPresenterProtocol!
    
    lazy var collectionView : UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        return collectionView
    }()
    
    private let bottomTabView : CustomTabView = {
        let view = CustomTabView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkOutView : CheckoutView = {
        let view = CheckoutView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewdidLoad()
    }
    
    deinit {
        presenter.removeNotifications()
    }
    
    //MARK: - Helpers
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                          height: .absolute(86),
                                                          spacing: 8)
                
                let group = CompositionalLayout.createGroup(alignment: .vertical,
                                                            width: .fractionalWidth(1),
                                                            height: .estimated(374),
                                                            items : [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.supplementariesFollowContentInsets = false
                
                return section
                
            } else if sectionNumber == 1 {
                
                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.33),
                                                          height: .fractionalHeight(1),
                                                          spacing: 8)
                
                let group = CompositionalLayout.createGroup(alignment: .horizontal,
                                                            width: .fractionalWidth(1),
                                                            height: .absolute(185),
                                                            items : [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .continuous
                
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                
                section.supplementariesFollowContentInsets = false
                
                return section
            }
            return nil
        }
    }
    
    func setupViews() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.addSubview(bottomTabView)
        bottomTabView.addSubview(checkOutView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -103),
            
            bottomTabView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomTabView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomTabView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomTabView.heightAnchor.constraint(equalToConstant: 103),
            
            checkOutView.topAnchor.constraint(equalTo: bottomTabView.topAnchor,constant: 16),
            checkOutView.leadingAnchor.constraint(equalTo: bottomTabView.leadingAnchor,constant: 16),
            checkOutView.trailingAnchor.constraint(equalTo: bottomTabView.trailingAnchor,constant: -16),
            checkOutView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(cellClass: ProductCollectionViewCell.self)
        collectionView.register(cellClass: BasketProductCollectionViewCell.self)
        collectionView.registerHeader(viewType: CollectionViewHeaderReusableView.self)
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(48)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    //MARK: - Actions
    
    @objc func handleTrashButton(){
        self.presentCustomAlert(message: "Sepeti boşaltmak istediğinizden emin misiniz ?",yesAction: {
            self.presenter.removeAllProduct()
        })
    }
}

//MARK: - BasketViewControllerProtocol

extension BasketViewController : BasketViewControllerProtocol {

    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showLoadingView() {
        self.showLoading()
    }
    
    func hideLoadingView() {
        self.hideLoading()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func showLeftBarButton() {
        self.showDismissBarButton()
    }
    
    func showRightBarButton() {
        self.showTrashBarButton(action: #selector(handleTrashButton))
    }
    
    func setupCheckoutView(_ totalPrice: Double) {
        let total = String(format: "₺%.2f", totalPrice)
        self.checkOutView.totalPrice = totalPrice
        self.checkOutView.didPressCheckoutButton = {[weak self] in
            self?.presentCustomAlert(message: "Toplam fiyatı \(total) olan ürünler için siparişi tamamlamak istiyor musun?",yesAction: {
                self?.presenter.removeAllProduct()
            })
        }
    }
    
    func checkBasketIsEmpty() {
        self.presenter.checkBasketIsEmpty()
    }
    
    func showError(_ message: String) {
        self.showAlert(title: "Error", message: message)
    }
}

//MARK: - UICollectionViewDataSource

extension BasketViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return presenter.numberOfBasketItems()
        } else if section == 1 {
            return presenter.numberOfSuggestedItems()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(with: BasketProductCollectionViewCell.self, for: indexPath)
            
            if let product = presenter.basketProduct(indexPath.row) {
                cell.cellPresenter = BasketProductCellPresenter(view: cell, basketProduct: product)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(with: ProductCollectionViewCell.self, for: indexPath)
            
            if let product = presenter.suggestedProduct(indexPath.row) {
                cell.suggestedCellPresenter = SuggestedProductCellPresenter(view: cell, suggestedProduct: product)
            }
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
}

//MARK: - UICollectionViewDelegate

extension BasketViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableHeaderView(with: CollectionViewHeaderReusableView.self, for: indexPath)
            header.setTitle("Önerilen Ürünler")
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
