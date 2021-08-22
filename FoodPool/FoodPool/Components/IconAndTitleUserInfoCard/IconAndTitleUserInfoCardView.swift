//
//  IconAndTitleUserInfoCardView.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit
import FontAwesome

class IconAndTitleUserInfoCardView: UIView {
    
    private let container: UIView = {
        var container = UIView()
        container.backgroundColor = .white
        return container
    }()

    private let imageView: UIImageView = {
        var image = UIImageView()
        image.image = UIImage.fontAwesomeIcon(name: .user, style: .solid, textColor: .mainOrange, size: .init(width: 50, height: 50))
        return image
    }()
    
    private let textContainer: UIView = {
        var container = UIView()
        container.backgroundColor = .white
        return container
    }()
    
    private let titleText: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Name Surname", txtFont: UIFont.boldSystemFont(ofSize: 18), alignment: .left, bgColor: .clear, txtColor: .mainDarkGray)
        return textView
    }()
    
    private let subtitleText: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "example@example.com", txtFont: UIFont.systemFont(ofSize: 12), alignment: .left, bgColor: .clear, txtColor: .mainGray)
        return textView
    }()
    
    private let subtitleTwoText: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "5442346767", txtFont: UIFont.systemFont(ofSize: 12), alignment: .left, bgColor: .clear, txtColor: .mainGray)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        container.fillSuperView()
        container.backgroundColor = .white
        
        container.addSubview(imageView)
        imageView.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: nil, padding: .init(top: 20.0, left: 20.0, bottom: 20.0, right: 0.0))
        imageView.anchorSize(size: .init(width: 100, height: 120))
        
        container.addSubview(textContainer)
        textContainer.anchor(top: container.topAnchor, leading: imageView.trailingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: .init(top: 20.0, left: 10.0, bottom: 10.0, right: 20.0))
        
        textContainer.addSubview(titleText)
        titleText.anchor(top: textContainer.topAnchor, leading: textContainer.leadingAnchor, bottom: nil, trailing: textContainer.trailingAnchor)
        titleText.anchorSize(size: .init(width: textContainer.frame.width, height: 30))
        
        textContainer.addSubview(subtitleText)
        subtitleText.anchor(top: titleText.bottomAnchor, leading: textContainer.leadingAnchor, bottom: nil, trailing: textContainer.trailingAnchor)
        subtitleText.anchorSize(size: .init(width: textContainer.frame.width, height: 30))
        
        textContainer.addSubview(subtitleTwoText)
        subtitleTwoText.anchor(top: subtitleText.bottomAnchor, leading: textContainer.leadingAnchor, bottom: nil, trailing: textContainer.trailingAnchor)
        subtitleTwoText.anchorSize(size: .init(width: textContainer.frame.width, height: 30))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: IconAndTitleUserInfoCardUIView) {
        titleText.text = model.title
        subtitleText.text = model.subtitle ?? ""
        subtitleTwoText.text = model.subtitleTwo ?? ""
    }
    
}
