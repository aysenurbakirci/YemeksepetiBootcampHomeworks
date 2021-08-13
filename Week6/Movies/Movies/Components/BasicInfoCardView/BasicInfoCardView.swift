//
//  BasicInfoCardView.swift
//  Movies
//
//  Created by Ayşe Nur Bakırcı on 13.08.2021.
//

import UIKit
import NetworkAPI

class BasicInfoCardView: UIView {

    private let cardContainer: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "onBoardingDrink")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let infoView: BasicTitleView = {
        var basicTitle = BasicTitleView()
        basicTitle.backgroundColor = .lightGray
        basicTitle.translatesAutoresizingMaskIntoConstraints = false
        return basicTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cardContainer)
        cardContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cardContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        cardContainer.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: cardContainer.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor).isActive = true

        cardContainer.addSubview(infoView)
        infoView.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor).isActive = true
        infoView.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
        func configure(movie: Movie) {
            preparePosterImage(with: movie.posterPath)
            infoView.configure(with: BasicTitleViewUIModel(title: movie.title, subtitle: movie.releaseDate))
        }
    
        private func preparePosterImage(with urlString: String?) {
            let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
            if let url = URL(string: fullPath) {
                imageView.sd_setImage(with: url, completed: nil)
            }
        }
}
