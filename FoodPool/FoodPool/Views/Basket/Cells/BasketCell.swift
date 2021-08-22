//
//  BasketCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 19.08.2021.
//

import UIKit

protocol BasketCellProtocol {
    func deleteToBasket(index: Int)
}

class BasketCell: UICollectionViewCell {
    
    var index: Int?
    var delegate: BasketCellProtocol?
    
    static let reuseIdentifier: String = "basketCellID"

    private let iconAndTitleCardView = IconAndTitleCardView()
    
    private let deleteButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .trash), for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconAndTitleCardView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconAndTitleCardView)
        iconAndTitleCardView.fillSuperView()
        
        addSubview(deleteButton)
        deleteButton.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0))
        deleteButton.addTarget(self, action: #selector(deleteBasket), for: .touchUpInside)
    }
    
    @objc private func deleteBasket() {
        if let index = index {
            delegate?.deleteToBasket(index: index)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: IconAndTitleCardUIView) {
        iconAndTitleCardView.configuration(with: model, imageFolder: "MealImages")
    }
}
