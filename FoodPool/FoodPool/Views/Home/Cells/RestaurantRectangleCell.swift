//
//  RestaurantRectangleCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit

class RestaurantRectangleCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "restaurantCellID"
    
    private let iconAndTitleView = IconAndTitleRectangleCardView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconAndTitleView.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(iconAndTitleView)
        iconAndTitleView.fillSuperView()
        
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: RestaurantModel) {
        let titleModel = TitleAndSubtitleUIModel(title: model.restaurantName, subtitle: model.restaurantCuisineType)
        let configModel = IconAndTitleRectangleCardUIView(imageName: model.restaurantImagePath, titleAndSubtitle: titleModel)
        iconAndTitleView.configuration(with: configModel, imageFolder: "RestaurantImages")
    }
    
}
