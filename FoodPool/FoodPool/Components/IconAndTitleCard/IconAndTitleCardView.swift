//
//  IconAndTitleCardView.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 16.08.2021.
//

import UIKit
import FontAwesome
import SDWebImage
import FirebaseStorage

class IconAndTitleCardView: UIView {
    
    private let titleAndSubtitle = TitleAndSubtitleView()
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "onBoardingHamburger")
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()
    
    private let stackIconAndTitle: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackIconAndTitle)
        backgroundColor = .white

        stackIconAndTitle.addArrangedSubview(imageView)
        imageView.anchorSize(size: .init(width: imageView.frame.size.width, height: imageView.frame.size.height))
        stackIconAndTitle.addArrangedSubview(titleAndSubtitle)
        stackIconAndTitle.fillSuperView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configuration(with model: IconAndTitleCardUIView, imageFolder: String) {
        
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
