//
//  SectionHeaderCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 12.08.2021.
//

import UIKit

class SectionHeaderCell: UICollectionReusableView {
    
    static let reuseIdentifier: String = "sectionHeaderCellID"
    
    var titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Categories"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .mainDarkGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with title: String) {
        titleLabel.text = title
    }
}
