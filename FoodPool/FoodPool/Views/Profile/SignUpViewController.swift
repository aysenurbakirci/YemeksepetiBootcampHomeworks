//
//  SignUpViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var signUpViewModel: SignUpViewModelProtocol! {
        didSet {
            signUpViewModel.delegate = self
        }
    }
    
    private let backgroundImage: UIImageView = {
        var image = UIImageView()
        image = UIImageView(image: UIImage(named: "background"))
        return image
    }()
    
    private let signUpContainer: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.addShadow(cornerRadius: 30)
        return view
        
    }()
    
    private let welcomeTitle: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Create Account,", txtFont: UIFont.boldSystemFont(ofSize: 24), alignment: .left, bgColor: .clear, txtColor: .mainDarkGray)
        return textView
    }()
    
    private let userFullName: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Full Name"
        textField.setLeftPaddingPoints(10)
        textField.addBorder(cornerRadius: 20)
        return textField
    }()
    
    private let userEmail: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Email"
        textField.setLeftPaddingPoints(10)
        textField.addBorder(cornerRadius: 20)
        return textField
    }()
    
    private let userPhone: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Phone"
        textField.setLeftPaddingPoints(10)
        textField.addBorder(cornerRadius: 20)
        return textField
    }()
    
    private let userPassword: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Password"
        textField.setLeftPaddingPoints(10)
        textField.addBorder(cornerRadius: 20)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton: UIButton = {
        var button = UIButton(type: .system)
        button.createButton(title: "Sign Up", titleColor: .white, bgColor: .mainOrange, cornerRadius: 20)
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userFullName.delegate = self
        userEmail.delegate = self
        userPhone.delegate = self
        userPassword.delegate = self
        
        configuration()
    }
    
    private func configuration() {
        
        view.addSubview(backgroundImage)
        backgroundImage.fillSuperView()
        
        view.addSubview(signUpContainer)
        signUpContainer.anchorSize(size: .init(width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.45))
        signUpContainer.anchorCenterX(to: self.view)
        signUpContainer.anchorCenterY(to: self.view)
        
        signUpContainer.addSubview(welcomeTitle)
        welcomeTitle.anchor(top: signUpContainer.topAnchor, leading: signUpContainer.leadingAnchor, bottom: nil, trailing: signUpContainer.trailingAnchor, padding: .init(top: 40.0, left: 20.0, bottom: 10.0, right: 0.0))
        welcomeTitle.anchorSize(size: .init(width: 0, height: 40))
        
        signUpContainer.addSubview(userFullName)
        userFullName.anchor(top: welcomeTitle.bottomAnchor, leading: signUpContainer.leadingAnchor, bottom: nil, trailing: signUpContainer.trailingAnchor, padding: .init(top: 10.0, left: 20.0, bottom: 0.0, right: 20.0))
        userFullName.anchorSize(size: .init(width: 0, height: 40))
        
        signUpContainer.addSubview(userEmail)
        userEmail.anchor(top: userFullName.bottomAnchor, leading: signUpContainer.leadingAnchor, bottom: nil, trailing: signUpContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        userEmail.anchorSize(size: .init(width: 0, height: 40))
        
        signUpContainer.addSubview(userPhone)
        userPhone.anchor(top: userEmail.bottomAnchor, leading: signUpContainer.leadingAnchor, bottom: nil, trailing: signUpContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        userPhone.anchorSize(size: .init(width: 0, height: 40))
        
        signUpContainer.addSubview(userPassword)
        userPassword.anchor(top: userPhone.bottomAnchor, leading: signUpContainer.leadingAnchor, bottom: nil, trailing: signUpContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        userPassword.anchorSize(size: .init(width: 0, height: 40))

        signUpContainer.addSubview(signUpButton)
        signUpButton.anchor(top: userPassword.bottomAnchor, leading: signUpContainer.leadingAnchor, bottom: nil, trailing: signUpContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        signUpButton.anchorSize(size: .init(width: self.view.frame.width * 0.8, height: 40.0))
        
    }
    
    @objc private func didTapSignUp() {
        signUpViewModel.userSignUp()
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    
    func getData() -> SignUpData? {
        let data: SignUpData = SignUpData(fullName: "", phone: "", email: "", password: "")
        return data
    }
    
    func successSignUp() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureSignUp(err: Error?) {
        showAlert(title: "Sign Up Error!", message: err?.localizedDescription ?? "")
    }
}
