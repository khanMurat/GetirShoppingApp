//
//  BasketViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import UIKit

protocol BasketViewControllerProtocol : AnyObject {
    func reloadData()
    func setupCollectionView()
    func showLoadingView()
    func hideLoadingView()
    func showLeftBarButton()
}

final class BasketViewController : BaseViewController {
    
    var presenter : BasketPresenterProtocol!
    
    lazy var collectionView : UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewdidLoad()
        setupCollectionView()
    }
    
    //    deinit {
    //        presenter.removeNotifications()
    //    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .absolute(86), spacing: 8)
                let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .estimated(374), items : [item])
                let section = NSCollectionLayoutSection(group: group)
                section.supplementariesFollowContentInsets = false
                return section
            } else if sectionNumber == 1 {
                
                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.33), height: .fractionalHeight(1), spacing: 8)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(185), items : [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                section.supplementariesFollowContentInsets = false
                return section
            }
            return nil
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
        collectionView.register(cellClass: BasketProductCollectionViewCell.self)
        collectionView.registerHeader(viewType: CollectionViewHeaderReusableView.self)
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(48)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

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
    
    func showLeftBarButton() {
        self.showDismissBarButton()
    }
}

extension BasketViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
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

extension BasketViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        presenter.didSelectItemAt(index: indexPath.row, in: indexPath.section)
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
