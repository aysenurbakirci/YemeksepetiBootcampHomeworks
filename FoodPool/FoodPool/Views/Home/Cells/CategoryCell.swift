//
//  CategoryCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit
import FirebaseStorage

class CategoryCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "categoryCellID"
    
    private let categoryImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let categoryTitle: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Category", txtFont: UIFont.systemFont(ofSize: 10), alignment: .center, bgColor: .mainOrange, txtColor: .white)
        return textView
    }()
    
    private let categoryContainer: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration()
    }
    
    private func configuration() {
        addSubview(categoryContainer)
        categoryContainer.fillSuperView()
        categoryContainer.addSubview(categoryTitle)
        categoryTitle.anchor(top: nil, leading: categoryContainer.leadingAnchor, bottom: categoryContainer.bottomAnchor, trailing: categoryContainer.trailingAnchor)
        categoryTitle.anchorSize(size: .init(width: categoryContainer.frame.width, height: 25))
        
        categoryContainer.addSubview(categoryImage)
        categoryImage.anchor(top: categoryContainer.topAnchor, leading: categoryContainer.leadingAnchor, bottom: categoryTitle.topAnchor, trailing: categoryContainer.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: CuisineModel) {
        fetchImage(folder: "CategoryImages", imageName: model.image)
        categoryTitle.text = model.cuisine
    }
    
    private func fetchImage (folder: String, imageName: String ) {
        let storage = Storage.storage().reference()
        storage.child("\(folder)/\(imageName)").downloadURL { url, error in
            if error != nil {
                print("Error save user: \(String(describing: error))")
            } else {
                DispatchQueue.main.async {
                    self.categoryImage.sd_setImage(with: url, completed: nil)
                }
            }
        }
    }
    
}
