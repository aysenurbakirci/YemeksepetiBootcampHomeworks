//
//  BasicTitleView.swift
//  Movies
//
//  Created by Ayşe Nur Bakırcı on 13.08.2021.
//

import UIKit

class BasicTitleView: UIView {
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        var label = UILabel()
        label.text = "Subtitle"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: BasicTitleViewUIModel) {
        titleLabel.text = model.title
        
        if let subtitle = model.subtitle {
            subtitleLabel.text = subtitle
        }
        else {
            subtitleLabel.isHidden = true
        }
    }
}
