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
    
    let collectionView = UICollectionView()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewdidLoad()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // item
        
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.25), height: .fractionalHeight(1), spacing: 8)
        
        // group
        
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.3), item:item,count: 3)
        
        // section
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        //return
        
        return UICollectionViewCompositionalLayout(section: section)
    }

}

extension HomeViewController : HomeViewControllerProtocol {
    
    func reloadData() {
        
    }
    
    func setupCollectionView() {
        collectionView.collectionViewLayout = createLayout()
    }
    
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func showError(_ message: String) {
        
    }
    
    
}
