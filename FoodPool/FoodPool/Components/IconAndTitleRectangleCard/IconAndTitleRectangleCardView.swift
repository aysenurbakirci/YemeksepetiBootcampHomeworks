//
//  IconAndTitleRectangleCardUIView.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 16.08.2021.
//

import UIKit
import FontAwesome
import SDWebImage
import FirebaseStorage

class IconAndTitleRectangleCardView: UIView {
    
    private let titleAndSubtitle = TitleAndSubtitleView()
    
    private let container: UIView = {
        var container = UIView()
        return container
    }()
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "onBoardingHamburger")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 170)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        container.fillSuperView()
        
        container.addSubview(titleAndSubtitle)
        titleAndSubtitle.anchor(top: nil, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor)
        titleAndSubtitle.anchorSize(size: .init(width: container.frame.width, height: 80))
        container.addSubview(imageView)
        imageView.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: titleAndSubtitle.topAnchor, trailing: container.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapAddButton() {
        print("add")
    }

    func configuration(with model: IconAndTitleRectangleCardUIView, imageFolder: String) {
        
        fetchImage(folder: imageFolder, imageName: model.imageName)
        titleAndSubtitle.configuration(with: model.titleAndSubtitle)
    }
    
    private func fetchImage (folder: String, imageName: String ) {
        let storage = Storage.storage().reference()
        storage.child("\(folder)/\(imageName)").downloadURL { url, error in
            if error != nil {
                print("Error save user: \(String(describing: error))")
            } else {
                DispatchQueue.main.async {
                    self.imageView.sd_setImage(with: url, completed: nil)
                }
            }
        }
    }
}
