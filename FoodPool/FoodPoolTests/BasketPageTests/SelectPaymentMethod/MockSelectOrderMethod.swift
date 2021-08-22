//
//  MockSelectOrderMethod.swift
//  FoodPoolTests
//
//  Created by Ayşe Nur Bakırcı on 22.08.2021.
//

import Foundation
@testable import FoodPool

class MockSelectPaymentMethodViewModel: SelectPaymentMethodViewModelProtocol {
    
    public init() {}
    weak var delegate: SelectPaymentMethodViewModelDelegate?
    
    var isLoaded = false
    var createdPaymentMethods = false
    
    func load() {
        self.isLoaded = true
    }
    
    func paymentMethod(indexPath: Int) -> PaymentMethodModel? {
        self.createdPaymentMethods = true
        return nil
    }
    
    var numberOfItemsPaymentMethods: Int = 0
    
}

class MockSelectPaymentMethodViewController: SelectPaymentMethodViewModelDelegate {
    
    var selectPaymentMethodsViewModel: SelectPaymentMethodViewModelProtocol! {
        didSet {
            selectPaymentMethodsViewModel.delegate = self
        }
    }

    var isInvokedShowLoading = false
    var isInvokedHideLoading = false
    var dataIsReloaded = false

    func showLoadingView() {
        self.isInvokedShowLoading = true
    }

    func hideLoadingView() {
        self.isInvokedHideLoading = true
    }

    func reloadData() {
        self.dataIsReloaded = true
    }
}
