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
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewdidLoad()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        // item
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.33), height: .fractionalHeight(1), spacing: 8)
        
        // group
        
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.25), items : [item])
        // section
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        section.orthogonalScrollingBehavior = .continuous
        
        
        //return
        
        return UICollectionViewCompositionalLayout(section: section)
    }


}

extension HomeViewController : HomeViewControllerProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .darkGray
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
        collectionView.register(SuggestedProductCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
    }

    
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func showError(_ message: String) {
        
    }
    
}

extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as? SuggestedProductCollectionViewCell else {
            fatalError("Unable to dequeue Reusable Cell")
        }
        
        if let product = presenter.product(indexPath.row) {
            
            cell.cellPresenter = SuggestedProductCellPresenter(view: cell, suggestedProduct: product)
        }
        return cell
    }

}

extension HomeViewController : UICollectionViewDelegate {
    
}
