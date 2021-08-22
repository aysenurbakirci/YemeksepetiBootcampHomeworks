//
//  BasketViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit

class BasketViewController: UICollectionViewController {
    
    init() {
        let layout = BasketViewController.createLayout()
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var basketViewModel: BasketViewModelProtocol! {
        didSet {
            basketViewModel.delegate = self
        }
    }

    private let continueContainer: UIView = {
        var container = UIView()
        container.backgroundColor = .white
        return container
    }()
    
    private let horizontalStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let continueButton: UIButton = {
        var button = UIButton(type: .system)
        button.createButton(title: "Continue", titleColor: .white, bgColor: .mainOrange, cornerRadius: 16)
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return button
    }()
    
    private let totalPrice: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "00.00", txtFont: UIFont.boldSystemFont(ofSize: 20), alignment: .right, bgColor: .clear, txtColor: .mainDarkGray)
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Basket"
        collectionViewConfiguration()
        configuration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        basketViewModel.load()
        self.totalPrice.text = basketViewModel.totalPrice
    }
    
    @objc private func didTapContinueButton() {
        if AuthUserModel.authUser.userID.isEmpty {
            showAlert(title: "You must login.", message: "You cannot create an order without logging in.")
        } else {
            let controller = SelectOrderMethodsViewController()
            let viewModel = SelectOrderMethodsViewModel(service: FoodPoolServices())
            controller.createOrderViewModel = viewModel
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func collectionViewConfiguration() {
        collectionView.backgroundColor = .mainBackgroundGray
        collectionView.register(BasketCell.self, forCellWithReuseIdentifier: BasketCell.reuseIdentifier)
    }
    
    private func configuration() {
        view.addSubview(continueContainer)
        continueContainer.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        continueContainer.anchorSize(size: .init(width: view.frame.size.width, height: view.frame.size.width * 0.4))
        
        continueContainer.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(continueButton)
        horizontalStack.addArrangedSubview(totalPrice)
        
        horizontalStack.anchor(top: continueContainer.topAnchor, leading: continueContainer.leadingAnchor, bottom: nil, trailing: continueContainer.trailingAnchor, padding: .init(top: 10.0, left: 10.0, bottom: 0.0, right: 10.0))
        horizontalStack.anchorSize(size: .init(width: view.frame.size.width, height: (view.frame.size.width * 0.4) - 120))
    }
}

extension BasketViewController {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))

            item.contentInsets.bottom = 8
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if basketViewModel.numberOfItemsMeal == 0 {
            collectionView.setEmptyBasketImage()
            continueContainer.isHidden = true
        } else {
            collectionView.restore()
            continueContainer.isHidden = false
        }
        return basketViewModel.numberOfItemsMeal
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketCell.reuseIdentifier, for: indexPath) as! BasketCell
        
        let model = basketViewModel.meal(indexPath: indexPath.row)
        let title = TitleAndSubtitleUIModel(title: model?.name ?? "Name", subtitle: "\(model?.price ?? "")$" )
        
        cell.configuration(with: IconAndTitleCardUIView(imageName: model?.image ?? "", titleAndSubtitle: title))
        
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
}

extension BasketViewController: BasketViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}

extension BasketViewController: BasketCellProtocol {
    func deleteToBasket(index: Int) {
        makeDeleteAlert(title: "Delete!", message: "This meal is deleting.", deleteIndex: index)
    }
}

extension BasketViewController {
    
    func makeDeleteAlert (title: String, message: String, deleteIndex: Int) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { action in
            BasketModel.basketList.menuModel.remove(at: deleteIndex)
            self.basketViewModel.load()
            self.totalPrice.text = self.basketViewModel.totalPrice
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
}
