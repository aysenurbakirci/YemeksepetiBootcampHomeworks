//
//  UserInformationHeaderCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 13.08.2021.
//

import UIKit
import FontAwesome

class UserInformationHeaderCell: UICollectionReusableView {
    
    static let reuseIdentifier: String = "sectionHeaderCellID"

    private lazy var restaurantInfoView = IconAndTitleUserInfoCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(restaurantInfoView)
        restaurantInfoView.fillSuperView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confirmation(with model: IconAndTitleUserInfoCardUIView) {
        restaurantInfoView.configuration(with: model)
    }
}
