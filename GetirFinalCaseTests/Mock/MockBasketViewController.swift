//
//  MockBasketViewController.swift
//  GetirFinalCaseTests
//
//  Created by Murat on 20.04.2024.
//

import XCTest
@testable import GetirFinalCase

final class MockBasketViewController: XCTestCase,BasketViewControllerProtocol {
    
    var totalPrice : Double?
    
    func reloadData() {}
    
    func setupViews() {}
    
    func showLoadingView() {}
    
    func hideLoadingView() {}
    
    func setTitle(_ title: String) {}
    
    func showLeftBarButton() {}
    
    func showRightBarButton() {}
    
    func setupCheckoutView(_ totalPrice: Double) {
        self.totalPrice = totalPrice
    }
    
    func checkBasketIsEmpty() {}
    
    func showError(_ message: String) {}
    
    
    
}
