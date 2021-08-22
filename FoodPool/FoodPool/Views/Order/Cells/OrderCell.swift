//
//  OrderCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 21.08.2021.
//

import UIKit

class OrderCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "orderCellID"
    
    private let titleAndSubtitle = TitleAndSubtitleView()
    private let totalPrice: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "00.00", txtFont: UIFont.boldSystemFont(ofSize: 14), alignment: .center, bgColor: .mainOrange, txtColor: .white)
        textView.layer.cornerRadius = 12
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(titleAndSubtitle)
        titleAndSubtitle.fillSuperView()
        
        addSubview(totalPrice)
        totalPrice.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        totalPrice.anchorCenterY(to: contentView)
        totalPrice.anchorSize(size: .init(width: 70, height: 32))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: TitleAndSubtitleUIModel, price: String) {
        titleAndSubtitle.configuration(with: model)
        totalPrice.text = "\(price)$"
    }
    
}
