//
//  HomeViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import UIKit

protocol HomeViewControllerProtocol : AnyObject {
    func reloadData()
    func setupCollectionView()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
    func setupBarButtonItem(_ totalPrice : Double)
    func showError(_ message:String)
}

final class HomeViewController: BaseViewController {
    
    //MARK: - Properties
    
    var presenter : HomePresenterProtocol!
    
    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var basketView = BasketView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewdidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewdidLoad()
    }
    
    deinit {
        presenter.removeNotifications()
    }
    
    //MARK: - Helpers
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.33), height: .fractionalHeight(1), spacing: 8)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(185), items : [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            } else if sectionNumber == 1 {
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 8)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(185), item: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 20)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            }
            return nil
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(25)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

//MARK: - HomeViewControllerProtocol

extension HomeViewController : HomeViewControllerProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(cellClass: ProductCollectionViewCell.self)
        collectionView.registerHeader(viewType: CollectionViewHeaderReusableView.self)
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
    
    func setupBarButtonItem(_ totalPrice: Double) {
        
        basketView.widthAnchor.constraint(equalToConstant: 91).isActive = true
        basketView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        basketView.setTotalPrice(totalPrice)
        basketView.onBasketTapped = {
            self.presenter.tappedBasket()
        }
        let basketButtonItem = UIBarButtonItem(customView: basketView)
        navigationItem.rightBarButtonItem = basketButtonItem
        
        if totalPrice > 0 {
            self.showBarButtonItemWithAnimation(basketView: basketView)
        } else {
            hideBarButtonItemWithAnimation(basketView: basketView)
        }
    }
    
    func showError(_ message: String) {
        self.showAlert(title: "Error", message: message)
    }
}

//MARK: - UICollectionViewDataSource

extension HomeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return presenter.numberOfHorizontalItems()
        } else if section == 1 {
            return presenter.numberOfVerticalItems()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            
            let cell = collectionView.dequeueReusableCell(with: ProductCollectionViewCell.self, for: indexPath)
            
            if let product = presenter.horizontalProduct(indexPath.row) {
                cell.suggestedCellPresenter = SuggestedProductCellPresenter(view: cell, suggestedProduct: product)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(with: ProductCollectionViewCell.self, for: indexPath)
            
            if let product = presenter.verticalProduct(indexPath.row) {
                cell.cellPresenter = ProductCellPresenter(view: cell, product: product)
            }
            return cell
        default:
            fatalError("Unexpected section")
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HomeViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row, in: indexPath.section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableHeaderView(with: CollectionViewHeaderReusableView.self, for: indexPath)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
