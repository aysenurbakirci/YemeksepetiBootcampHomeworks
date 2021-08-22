//
//  VerticalRestaurantCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 12.08.2021.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "restaurantCellID"

    private let iconAndTitleCardView = IconAndTitleCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconAndTitleCardView)
        iconAndTitleCardView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: IconAndTitleCardUIView) {
        iconAndTitleCardView.configuration(with: model, imageFolder: "RestaurantImages")
    }
}
