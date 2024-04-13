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
    
}

final class BasketViewController : BaseViewController {
    
    //    var presenter : DetailPresenterProtocol!
    
    lazy var collectionView : UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter.viewdidLoad()
        setupCollectionView()
    }
    
//    deinit {
//        presenter.removeNotifications()
//    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .absolute(74), spacing: 8)
                let group = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .absolute(374), items : [item])
                let section = NSCollectionLayoutSection(group: group)
                section.supplementariesFollowContentInsets = false
                return section
            } else if sectionNumber == 1 {
                
                let item = CompositionalLayout.createItem(width: .fractionalWidth(0.33), height: .fractionalHeight(1), spacing: 8)
                let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .absolute(185), items : [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
//                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
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
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionView.register(BasketProductCollectionViewCell.self, forCellWithReuseIdentifier: "identifier")
        collectionView.register(CollectionViewHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionViewHeaderReusableView")
    }
}

extension BasketViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 10
        } else if section == 1 {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "identifier", for: indexPath) as? BasketProductCollectionViewCell else {
                fatalError("Unable to dequeue HorizontalProductCollectionViewCell")
            }
//            if let product = presenter.horizontalProduct(indexPath.row) {
//                cell.suggestedCellPresenter = SuggestedProductCellPresenter(view: cell, suggestedProduct: product)
//            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as? ProductCollectionViewCell else {
                fatalError("Unable to dequeue VerticalProductCollectionViewCell")
            }
//            if let product = presenter.verticalProduct(indexPath.row) {
//                cell.cellPresenter = ProductCellPresenter(view: cell, product: product)
//            }
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
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeaderReusableView", for: indexPath) as! CollectionViewHeaderReusableView
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
