//
//  TitleAndSubtitleView.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 16.08.2021.
//

import UIKit

class TitleAndSubtitleView: UIView {
    
    private let titleText: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Title", txtFont: UIFont.boldSystemFont(ofSize: 16), alignment: .left, bgColor: .clear, txtColor: .mainDarkGray)
        return textView
    }()
    
    private let subtitleText: UITextView = {
        var textView = UITextView()
        textView.createText(txt: "Description", txtFont: UIFont.boldSystemFont(ofSize: 14), alignment: .left, bgColor: .clear, txtColor: .mainOrange)
        return textView
    }()
    
    private let stackTitleAndSubtitle: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackTitleAndSubtitle)
        stackTitleAndSubtitle.addArrangedSubview(titleText)
        stackTitleAndSubtitle.addArrangedSubview(subtitleText)
        stackTitleAndSubtitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
        anchorSize(size: .init(width: frame.size.width, height: titleText.frame.size.height + subtitleText.frame.size.height))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with model: TitleAndSubtitleUIModel) {
        titleText.text = model.title

        if let subtitle = model.subtitle {
            subtitleText.text = subtitle

        } else {
            subtitleText.isHidden = true
        }
    }
}
