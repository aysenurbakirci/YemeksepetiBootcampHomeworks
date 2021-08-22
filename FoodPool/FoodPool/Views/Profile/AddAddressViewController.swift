//
//  AddAddressViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 13.08.2021.
//

import UIKit


class AddAddressViewController: UIViewController, UITextFieldDelegate {
    
    var addAddressViewModel: AddAddressViewModelProtocol! {
        didSet {
            addAddressViewModel.delegate = self
        }
    }

    private let welcomeTitle: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Add Address,", txtFont: UIFont.boldSystemFont(ofSize: 24), alignment: .left, bgColor: .white, txtColor: .mainDarkGray)
        return textView
    }()
    
    private let addAddressContainer: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let addressTitle: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Address Title"
        textField.setLeftPaddingPoints(10)
        textField.addBorder(cornerRadius: 20)
        return textField
    }()
    
    private let addressDescription: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Address Description"
        textField.setLeftPaddingPoints(10)
        textField.addBorder(cornerRadius: 20)
        return textField
    }()
    
    private let province: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Province"
        textField.setLeftPaddingPoints(10)
        textField.addBorder(cornerRadius: 20)
        return textField
    }()
    
    private let addAddressButton: UIButton = {
        var button = UIButton(type: .system)
        button.createButton(title: "Add Address", titleColor: .white, bgColor: .mainOrange, cornerRadius: 20)
        button.addTarget(self, action: #selector(didTapAddAddress), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTitle.delegate = self
        addressDescription.delegate = self
        province.delegate = self
        
        configuration()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addressTitle.becomeFirstResponder()

    }
    
    private func configuration() {
        
        view.addSubview(addAddressContainer)
        view.backgroundColor = .white
        addAddressContainer.anchorSize(size: .init(width: self.view.frame.width, height: self.view.frame.height * 0.5))
        addAddressContainer.anchorCenterX(to: self.view)
        addAddressContainer.anchorCenterY(to: self.view)

        view.addSubview(welcomeTitle)
        welcomeTitle.anchor(top: addAddressContainer.topAnchor, leading: addAddressContainer.leadingAnchor, bottom: nil, trailing: addAddressContainer.trailingAnchor, padding: .init(top: 40.0, left: 20.0, bottom: 10.0, right: 0.0))
        welcomeTitle.anchorSize(size: .init(width: 0, height: 40))

        view.addSubview(addressTitle)
        addressTitle.anchor(top: welcomeTitle.bottomAnchor, leading: addAddressContainer.leadingAnchor, bottom: nil, trailing: addAddressContainer.trailingAnchor, padding: .init(top: 10.0, left: 20.0, bottom: 0.0, right: 20.0))
        addressTitle.anchorSize(size: .init(width: 0, height: 40))

        view.addSubview(addressDescription)
        addressDescription.anchor(top: addressTitle.bottomAnchor, leading: addAddressContainer.leadingAnchor, bottom: nil, trailing: addAddressContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        addressDescription.anchorSize(size: .init(width: 0, height: 40))

        view.addSubview(province)
        province.anchor(top: addressDescription.bottomAnchor, leading: addAddressContainer.leadingAnchor, bottom: nil, trailing: addAddressContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        province.anchorSize(size: .init(width: 0, height: 40))

        view.addSubview(addAddressButton)
        addAddressButton.anchor(top: province.bottomAnchor, leading: addAddressContainer.leadingAnchor, bottom: nil, trailing: addAddressContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        addAddressButton.anchorSize(size: .init(width: self.view.frame.width * 0.8, height: 40.0))
        
    }
    
    @objc private func didTapAddAddress() {
        addAddressViewModel.addNewAddress()
    }
}

extension AddAddressViewController: AddAddressViewModelDelegate {

    func getData() -> AddAddressData? {
        let data: AddAddressData = AddAddressData(addressTitle: "", address: "", province: "")
        return data
    }
    
    func successAddAddress() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureAddAddress(err: Error?) {
        showAlert(title: "Error!", message: err?.localizedDescription ?? "")
    }
    
}
