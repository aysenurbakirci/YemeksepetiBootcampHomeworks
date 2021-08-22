//
//  UICollectionView+Extensions.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 16.08.2021.
//

import UIKit

extension UICollectionView {
    
    func setEmptyBasketImage() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        view.backgroundColor = .white
        
        let image = UIImageView(image: UIImage(named: "emptyBasket"))
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        view.addSubview(image)
        image.anchorCenterY(to: view)
        image.anchorCenterX(to: view)
        
        self.backgroundView = view
    }
    
    func setEmptyMessage(_ message: String) {
        
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textColor = .black
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        
        self.backgroundView = lblMessage
    }

    func restore() {
        self.backgroundView = nil
    }
    
}
