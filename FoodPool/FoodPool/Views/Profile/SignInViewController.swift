//
//  OnboardingViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 9.08.2021.
//

import UIKit

class SignInViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var signInViewModel: SignInViewModelProtocol! {
        didSet {
            signInViewModel.delegate = self
        }
    }
    
    private let backgroundImage: UIImageView = {
        var image = UIImageView()
        image = UIImageView(image: UIImage(named: "background"))
        return image
    }()
    
    private let signInContainer: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.addShadow(cornerRadius: 30)
        return view
        
    }()
    
    private let welcomeTitle: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Welcome,", txtFont: UIFont.boldSystemFont(ofSize: 24), alignment: .left, bgColor: .clear, txtColor: .mainDarkGray)
        return textView
    }()
    
    private let userEmail: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Email"
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
    
    private let signInButton: UIButton = {
        var button = UIButton(type: .system)
        button.createButton(title: "Sign In", titleColor: .white, bgColor: .mainOrange, cornerRadius: 20)
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()
    
    private let forgatPasswordButton: UIButton = {
        var button = UIButton(type: .system)
        button.createButton(title: "Forgat", titleColor: .mainOrange, bgColor: .clear, cornerRadius: 20)
        button.addTarget(self, action: #selector(didTapForgatPassword), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        var button = UIButton(type: .system)
        button.createButton(title: "Sign Up", titleColor: .mainDarkGray, bgColor: .clear, cornerRadius: 20)
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()
    
    private let passwordInputStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmail.delegate = self
        userPassword.delegate = self
        
        configuration()
    }
    
    private func configuration() {
        
        view.addSubview(backgroundImage)
        backgroundImage.fillSuperView()
        view.addSubview(signInContainer)
        signInContainer.anchorSize(size: .init(width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.4))
        signInContainer.anchorCenterX(to: self.view)
        signInContainer.anchorCenterY(to: self.view)
        
        signInContainer.addSubview(welcomeTitle)
        welcomeTitle.anchor(top: signInContainer.topAnchor, leading: signInContainer.leadingAnchor, bottom: nil, trailing: signInContainer.trailingAnchor, padding: .init(top: 40.0, left: 20.0, bottom: 10.0, right: 0.0))
        welcomeTitle.anchorSize(size: .init(width: 0, height: 40))
        
        signInContainer.addSubview(userEmail)
        userEmail.anchor(top: welcomeTitle.bottomAnchor, leading: signInContainer.leadingAnchor, bottom: nil, trailing: signInContainer.trailingAnchor, padding: .init(top: 10.0, left: 20.0, bottom: 0, right: 20.0))
        userEmail.anchorSize(size: .init(width: 0, height: 40))
        
        passwordInputStack.addArrangedSubview(userPassword)
        passwordInputStack.addArrangedSubview(forgatPasswordButton)
        forgatPasswordButton.anchorSize(size: .init(width: 50.0, height: 40.0))
        
        signInContainer.addSubview(passwordInputStack)
        passwordInputStack.anchor(top: userEmail.bottomAnchor, leading: signInContainer.leadingAnchor, bottom: nil, trailing: signInContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0, right: 20.0))
        passwordInputStack.anchorSize(size: .init(width: 0, height: 40))

        signInContainer.addSubview(signInButton)
        signInButton.anchor(top: passwordInputStack.bottomAnchor, leading: signInContainer.leadingAnchor, bottom: nil, trailing: signInContainer.trailingAnchor, padding: .init(top: 20.0, left: 20.0, bottom: 0.0, right: 20.0))
        signInButton.anchorSize(size: .init(width: self.view.frame.width * 0.8, height: 40.0))
        
        signInContainer.addSubview(signUpButton)
        signUpButton.anchor(top: signInButton.bottomAnchor, leading: signInContainer.leadingAnchor, bottom: nil, trailing: signInContainer.trailingAnchor)
        signUpButton.anchorSize(size: .init(width: self.view.frame.width * 0.8, height: 40.0))
        
    }
    
    
    @objc private func didTapSignIn() {
        signInViewModel.userSignIn()
    }
    
    @objc private func didTapForgatPassword() {
        signInViewModel.userForgatPassword()
    }
    
    @objc private func didTapSignUp() {
        let view = SignUpViewController()
        let viewModel = SignUpViewModel(service: FoodPoolServices())
        view.signUpViewModel = viewModel
        let navigation = UINavigationController(rootViewController: view)
        navigation.isNavigationBarHidden = true
        present(navigation, animated: true, completion: nil)
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func getData() -> SignInData? {
        let signInData: SignInData = SignInData(email: userEmail.text!, password: userPassword.text!)
        return signInData
    }
    
    func successSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureSignIn(err: Error?) {
        showAlert(title: "Error!", message: err?.localizedDescription ?? "")
    }
}
