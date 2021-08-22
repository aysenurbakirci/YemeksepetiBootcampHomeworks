//
//  MethodCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 16.08.2021.
//

import UIKit

class MethodCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "methodCellID"
    
    private let titleAndSubtitle = TitleAndSubtitleView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(titleAndSubtitle)
        titleAndSubtitle.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: TitleAndSubtitleUIModel) {
        titleAndSubtitle.configuration(with: model)
    }
    
}
