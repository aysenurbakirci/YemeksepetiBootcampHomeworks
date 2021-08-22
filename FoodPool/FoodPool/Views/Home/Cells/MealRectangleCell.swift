//
//  MealRectangleCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 18.08.2021.
//

import UIKit

protocol MealRectangleCellProtocol {
    func addToBasket(model: RestaurantMenuModel)
}

class MealRectangleCell: UICollectionViewCell {
    
    var model: RestaurantMenuModel?
    var delegate: MealRectangleCellProtocol?
    
    static let reuseIdentifier: String = "mealCellID"
    private let currency = "$"
    
    private let iconAndTitleView = IconAndTitleRectangleCardView()

    
    private let addButton: UIButton = {
        var button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 26, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .plusCircle), for: .normal)
        button.setTitleColor(.mainOrange, for: .normal)
        button.addShadow(cornerRadius: 8)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconAndTitleView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(iconAndTitleView)
        iconAndTitleView.fillSuperView()
        
        backgroundColor = .white
        
        addSubview(addButton)
        addButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0.0, left: 0.0, bottom: 10.0, right: 10.0))
        addButton.anchorSize(size: .init(width: addButton.frame.size.width, height: addButton.frame.size.height))
        addButton.addTarget(self, action: #selector(addBasket), for: .touchUpInside)
        
    }
    
    @objc private func addBasket() {
        if let model = model {
            delegate?.addToBasket(model: model)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: RestaurantMenuModel) {
        let titleModel = TitleAndSubtitleUIModel(title: model.name, subtitle: "\(model.price)\(currency)")
        let configModel = IconAndTitleRectangleCardUIView(imageName: model.image, titleAndSubtitle: titleModel)
        iconAndTitleView.configuration(with: configModel, imageFolder: "MealImages")
        
    }
    
}
