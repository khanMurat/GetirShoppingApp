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
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension HomeViewController : HomeViewControllerProtocol {
    
    func reloadData() {
        
    }
    
    func setupCollectionView() {
        
    }
    
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func showError(_ message: String) {
        
    }
    
    
}
