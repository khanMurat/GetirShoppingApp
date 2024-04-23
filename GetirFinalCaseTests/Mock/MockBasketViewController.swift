//
//  MockBasketViewController.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 20.04.2024.
//

import Foundation
@testable import GetirFinalCase

final class MockBasketViewController: BasketViewControllerProtocol {
    
    var totalPrice: Double?
    var isSetupViewsCalled = false
    var setupViewsCallCount = 0

    var isReloadDataCalled = false
    var reloadDataCallCount = 0

    var isShowErrorCalled = false
    var showErrorCallCount = 0
    var lastErrorMessage: String?

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
    
    func setupViews() {
        isSetupViewsCalled = true
        setupViewsCallCount += 1
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
    
    func showLeftBarButton() {}
    func showRightBarButton() {}
    
    func setupCheckoutView(_ totalPrice: Double) {
        self.totalPrice = totalPrice
    }
    
    func checkBasketIsEmpty() {}
    
    func showError(_ message: String) {
        isShowErrorCalled = true
        showErrorCallCount += 1
        lastErrorMessage = message
    }
    
    func presentAlert() {}
}
