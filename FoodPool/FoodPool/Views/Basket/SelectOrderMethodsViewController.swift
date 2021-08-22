//
//  SelectOrderInformationViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 13.08.2021.
//

import UIKit

class SelectOrderMethodsViewController: UIViewController {
    
    var paymentMethod: PaymentMethodModel? = nil
    var address: UserAddressesModel? = nil
    let notificationCenter: NotificationCenter = NotificationCenter.default
    
    var createOrderViewModel: SelectOrderMethodsViewModelProtocol! {
        didSet {
            createOrderViewModel.delegate = self
        }
    }
    
    private let selectPaymentMethod: UIButton = {
        
        var button = UIButton(type: .system)
        button.setTitle("Select Payment Method", for: .normal)
        button.setTitleColor(.mainDarkGray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapSelectPayment), for: .touchUpInside)
        
        return button
        
    }()
    
    private let selectAddress: UIButton = {
        
        var button = UIButton(type: .system)
        button.setTitle("Select Address", for: .normal)
        button.setTitleColor(.mainDarkGray, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapSelectAddress), for: .touchUpInside)
        
        return button
        
    }()
    
    private let createOrderButton: UIButton = {
        
        var button = UIButton(type: .system)
        button.setTitle("Cerate Order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainOrange
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapCreateOrder), for: .touchUpInside)
        button.isHidden = true
        
        return button
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notificationCenter.addObserver(self, selector: #selector(handleData(notification:)), name: .sendDataNotification, object: nil)
        if paymentMethod != nil {
            selectPaymentMethod.setTitle(paymentMethod?.methodName, for: .normal)
        }
        if address != nil {
            selectAddress.setTitle(address?.addressTitle, for: .normal)
        }
        if paymentMethod != nil && address != nil {
            createOrderButton.isHidden = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }
    
    private func configuration() {
        view.backgroundColor = .mainBackgroundGray
        
        view.addSubview(selectPaymentMethod)
        selectPaymentMethod.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0))
        selectPaymentMethod.anchorSize(size: .init(width: self.view.frame.size.width, height: 60))
        
        view.addSubview(selectAddress)
        selectAddress.anchor(top: selectPaymentMethod.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10.0, left: 0.0, bottom: 0.0, right: 0.0))
        selectAddress.anchorSize(size: .init(width: self.view.frame.size.width, height: 60))
        
        view.addSubview(createOrderButton)
        createOrderButton.anchor(top: selectAddress.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20.0, left: 10.0, bottom: 0.0, right: 10.0))
        createOrderButton.anchorCenterX(to: view)
        createOrderButton.anchorSize(size: .init(width: self.view.frame.size.width * 0.5, height: 40))
    }
    
    @objc func handleData(notification: Notification) {
        
        if let paymentMethod = notification.userInfo?["paymentMethod"] as? PaymentMethodModel{
            self.paymentMethod = paymentMethod
        }
        
        if let address = notification.userInfo?["address"] as? UserAddressesModel {
            self.address = address
        }
    }
    
    @objc private func didTapSelectPayment() {
        
        let controller = SelectPaymentMethodViewController()
        let viewModel = SelectPaymentMethodViewModel(service: FoodPoolServices())
        controller.selectPaymentModelViewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc private func didTapSelectAddress() {
        
        let controller = SelectAddressViewController()
        let viewModel = SelectAddressViewModel(service: FoodPoolServices())
        controller.selectAddressViewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc private func didTapCreateOrder() {
        createOrderViewModel.create()
        BasketModel.basketList.menuModel = []
        BasketModel.basketList.restaurant = ""
        BasketModel.basketList.totalPrice = 0.0
    }
}

extension SelectOrderMethodsViewController: SelectOrderMethodsViewModelDelegate {
    func successOrder() {
        self.tabBarController?.selectedIndex = 2
    }
    
    func failureOrder() {
        showAlert(title: "Failure!", message: "Your order could not be created.")
    }
    
    func getData() -> CreateOrderData? {
        
        let orderData: CreateOrderData = CreateOrderData(mealList: createMealList(menuModel: BasketModel.basketList.menuModel), price: String(BasketModel.basketList.totalPrice), state: "current", nameRestaurant: BasketModel.basketList.restaurant, userID: AuthUserModel.authUser.userID, paymentMethod: self.paymentMethod?.methodName ?? "Online")
        return orderData
    }
}

extension SelectOrderMethodsViewController {
    func createMealList(menuModel: [RestaurantMenuModel]) -> [String] {
        var mealList: [String] = []
        for meal in menuModel {
            mealList.append(meal.name)
        }
        return mealList
    }
}
