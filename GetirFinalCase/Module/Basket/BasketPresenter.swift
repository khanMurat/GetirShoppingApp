//
//  BasketPresenter.swift
//  GetirFinalCase
//
//  Created by Murat on 13.04.2024.
//

import Foundation

protocol BasketPresenterProtocol : AnyObject {
    func viewdidLoad()
    func numberOfSections() -> Int
    func numberOfSuggestedItems() -> Int
    func numberOfBasketItems() -> Int
    func checkBasketIsEmpty()
    func suggestedProduct(_ index : Int) -> SuggestedProduct?
    func basketProduct(_ index : Int) -> RealmProduct?
    func removeAllProduct()
    func checkOutProduct()
    func removeNotifications()
}

final class BasketPresenter {
    
    unowned var view : BasketViewController!
    let router : BasketRouterProtocol!
    let interactor : BasketInteractorProtocol!
    
    var suggestedProducts : [SuggestedProduct] = []
    var basketProducts : [RealmProduct] = []
    var totalPrice : Double = 0.0
    
    init(view: BasketViewController, router: BasketRouterProtocol, interactor: BasketInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension BasketPresenter : BasketPresenterProtocol {
    
    func viewdidLoad() {
        fetchBasketProducts()
        fetchSuggestedProducts()
        view.setupViews()
        view.setTitle("Sepetim")
        view.showLeftBarButton()
        view.showRightBarButton()
        setupNotifications()
        view.setupCheckoutView(totalPrice)
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfSuggestedItems() -> Int {
        return suggestedProducts.count
    }
    
    func numberOfBasketItems() -> Int {
        return basketProducts.count
    }
    
    func checkBasketIsEmpty() {
        if basketProducts.isEmpty {
            self.router.navigate(.homeView)
        }
    }
    
    func suggestedProduct(_ index: Int) -> SuggestedProduct? {
        return suggestedProducts[index]
    }
    
    func basketProduct(_ index: Int) -> RealmProduct? {
        return basketProducts[index]
    }
    
    func removeAllProduct() {
        interactor.removeAllProductFromBasket()
    }
    
    func checkOutProduct() {
        interactor.checkOutProducts()
    }
    
    func removeNotifications() {
        interactor.removeNotifications()
    }
    
    private func fetchSuggestedProducts(){
        interactor.fetchSuggestedProducts()
    }
    
    private func fetchBasketProducts(){
        view.showLoadingView()
        interactor.fetchBasketProducts()
    }
    
    private func setupNotifications(){
        interactor.setupNotifications()
    }
    
    private func showOrderCompletionAlert() {
        self.view.presentCustomAlert(
            message: "Siparişiniz başarıyla oluşturulmuştur.",
            yesAction: {
                self.router.navigate(.homeView)
            },
            noButtonHidden: true,
            yesButtonTitle: "Tamam"
        )
    }
}

extension BasketPresenter : BasketInteractorOutputProtocol {
    
    func fetchBasketProductsOutput(_ result: [RealmProduct]) {
        self.basketProducts = result
        self.view.reloadData()
    }
    
    func fetchSuggestedProductsOutput(_ result: [SuggestedProduct]) {
        view.hideLoadingView()
        self.suggestedProducts = result
        self.view.reloadData()
    }
    
    func fetchBasketProductsTotalPriceOutput(_ result: Double) {
        self.totalPrice = result
        self.view.setupCheckoutView(result)
    }
    
    func removeAllProductFromBasketOutput(_ result: Bool) {
        if result{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.router.navigate(.homeView)
            }
        }
    }
    
    func checkOutProductsOutput(_ result: Bool) {
        if result{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showOrderCompletionAlert()
            }
        }
    }
    
    func checkBasketIsEmpty(_ result: Bool) {
        if result {
            self.view.checkBasketIsEmpty()
        }
    }
    
    func setupError(_ result: any Error) {
        self.view.showError(result.localizedDescription)
    }
}
