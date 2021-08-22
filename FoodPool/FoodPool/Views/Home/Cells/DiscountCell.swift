//
//  DiscountCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit
import SDWebImage
import FirebaseStorage

class DiscountCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "discountCellID"
    
    private let discountImage = UIImageView()
    private let imageContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageContainer)
        imageContainer.fillSuperView()
        
        imageContainer.addSubview(discountImage)
        discountImage.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with imageName: String) {
        
        let storage = Storage.storage().reference()
        
        storage.child("DiscountImages/\(imageName)").downloadURL { url, error in
            if error != nil {
                print("Error save user: \(String(describing: error))")
            } else {
                DispatchQueue.main.async {
                    self.discountImage.sd_setImage(with: url, completed: nil)
                }
            }
        }
    }
}
