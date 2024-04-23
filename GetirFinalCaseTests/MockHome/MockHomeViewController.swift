//
//  MockHomeViewController.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 23.04.2024.
//

import Foundation
@testable import GetirFinalCase

final class MockHomeViewController : HomeViewControllerProtocol {
    
    var totalPrice : Double?
    var isSetupCollectionViewsCalled = false
    var setupCollectionViewsCallCount = 0
    
    var isReloadDataCalled = false
    var reloadDataCallCount = 0
    
    var isShowLoadingViewCalled = false
    var showLoadingViewCallCount = 0
    
    var isHideLoadingViewCalled = false
    var hideLoadingViewCallCount = 0
    
    var titleSet: String?
    var setTitleCallCount = 0
    
    func reloadData() {
        isReloadDataCalled = true
        reloadDataCallCount += 1
    }
    
    func setupCollectionView() {
        isSetupCollectionViewsCalled = true
        setupCollectionViewsCallCount += 1
    }
    
    func showLoadingView() {
        isShowLoadingViewCalled = true
        showLoadingViewCallCount += 1
    }
    
    func hideLoadingView() {
        isHideLoadingViewCalled = true
        hideLoadingViewCallCount += 1
    }
    
    func setTitle(_ title: String) {
        titleSet = title
        setTitleCallCount += 1
    }
    
    func setupBarButtonItem(_ totalPrice: Double) {
        self.totalPrice = totalPrice
    }
    
    func showError(_ message: String) {}
    

}
