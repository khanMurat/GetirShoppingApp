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
    var isReloadDataCalled = false
    var isShowErrorCalled = false
    var lastErrorMessage: String?
    
    
    func reloadData() {
        isReloadDataCalled = true
    }
    
    func setupViews() {
        isSetupViewsCalled = true
    }
    
    func showLoadingView() {}
    
    func hideLoadingView() {}
    
    func setTitle(_ title: String) {}
    
    func showLeftBarButton() {}
    
    func showRightBarButton() {}
    
    func setupCheckoutView(_ totalPrice: Double) {
        self.totalPrice = totalPrice
    }
    
    func checkBasketIsEmpty() {}
    
    func showError(_ message: String) {
        isShowErrorCalled = true
        lastErrorMessage = message
    }
    
    func presentAlert() {}
    
}
