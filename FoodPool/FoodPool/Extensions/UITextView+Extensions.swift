//
//  UITextView+Extensions.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 16.08.2021.
//

import Foundation
import UIKit

extension UITextView {
    
    func createText(txt: String, txtFont: UIFont, alignment: NSTextAlignment, bgColor: UIColor, txtColor: UIColor) {
        text = txt
        font = txtFont
        textAlignment = alignment
        backgroundColor = bgColor
        textColor = txtColor
        isUserInteractionEnabled = false
        isEditable = false
    }
}
