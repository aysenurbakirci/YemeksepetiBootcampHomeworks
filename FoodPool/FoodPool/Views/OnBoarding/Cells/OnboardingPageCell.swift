//
//  OnboardingPageCell.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 9.08.2021.
//

import UIKit

struct OnBoardingUIModel {
    var imageName: String
    var title: String
    var description: String
}

class OnboardingPageCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "onBoardingCell"
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView = UIImageView(image: UIImage(named: "onBoardingHamburger"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptionTextTitle: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Delicious!", txtFont: UIFont.boldSystemFont(ofSize: 20), alignment: .center, bgColor: .clear, txtColor: .black)
        return textView
    }()
    
    private let descriptionText: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Delicious!", txtFont: UIFont.systemFont(ofSize: 16), alignment: .center, bgColor: .clear, txtColor: .mainGray)
        return textView
    }()
    
    private let imageContainerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration()

    }
    
    private func configuration() {
        addSubview(imageContainerView)
        imageContainerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        imageContainerView.anchorSize(size: .init(width: frame.width, height: frame.height * 0.5))
        
        imageContainerView.addSubview(imageView)
        imageView.anchor(top: imageContainerView.topAnchor, leading: imageContainerView.leadingAnchor, bottom: imageContainerView.bottomAnchor, trailing: imageContainerView.trailingAnchor, padding: .init(top: 40.0, left: 30.0, bottom: 10.0, right: 30.0))
        
        addSubview(descriptionTextTitle)
        descriptionTextTitle.anchor(top: imageContainerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        descriptionTextTitle.anchorSize(size: .init(width: frame.width, height: 50.0))
        
        addSubview(descriptionText)
        descriptionText.anchor(top: descriptionTextTitle.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0.0, left: 40.0, bottom: 0.0, right: 40.0))
        descriptionText.anchorSize(size: .init(width: frame.width, height: 100.0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: OnBoardingUIModel) {
        imageView.image = UIImage(named: model.imageName)
        descriptionTextTitle.text = model.title
        descriptionText.text = model.description
    }
}
