//
//  SelectPaymentMethodViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 20.08.2021.
//

import FirebaseFirestore

protocol SelectPaymentMethodViewModelProtocol {
    
    func load()
    func paymentMethod(indexPath: Int) -> PaymentMethodModel?
    var numberOfItemsPaymentMethods: Int { get }
    var delegate: SelectPaymentMethodViewModelDelegate? { get set }
}

protocol SelectPaymentMethodViewModelDelegate: AnyObject {
    
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class SelectPaymentMethodViewModel {
    
    private var paymentMethods: [PaymentMethodModel] = []
    
    let service: FoodPoolPaymentMethodsServiceProtocol
    
    weak var delegate: SelectPaymentMethodViewModelDelegate?
    
    init(service: FoodPoolPaymentMethodsServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchPaymentMethods() {
        paymentMethods.removeAll()
        delegate?.showLoadingView()
        service.fetchPaymentMethods { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let method):
                self.paymentMethods.append(method)
                print("METHOD: \(method)")
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SelectPaymentMethodViewModel: SelectPaymentMethodViewModelProtocol {

    func load() {
        fetchPaymentMethods()
    }
    
    func paymentMethod(indexPath: Int) -> PaymentMethodModel? {
        paymentMethods[safe: indexPath]
    }
    
    var numberOfItemsPaymentMethods: Int {
        paymentMethods.count
    }
}
