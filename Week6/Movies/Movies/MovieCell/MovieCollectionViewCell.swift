//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Kerim Caglar on 3.08.2021.
//

import UIKit
import NetworkAPI
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    private let cellView = BasicInfoCardView()
    
    var movieModel: Movie? {
        didSet{
            guard movieModel != nil else { return }
            cellView.configure(movie: movieModel!)
        }
    }
    
    static let reuseIdentifier: String = "movieModelID"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
