//
//  UIButton+Extensions.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 16.08.2021.
//

import Foundation
import UIKit

extension UIButton {
    
    func createButton(title: String, titleColor: UIColor, bgColor: UIColor, cornerRadius: CGFloat) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = bgColor
        layer.cornerRadius = cornerRadius
    }
}
