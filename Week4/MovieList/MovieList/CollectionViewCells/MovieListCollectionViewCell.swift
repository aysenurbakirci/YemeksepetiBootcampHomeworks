//
//  MovieListCollectionViewCell.swift
//  MovieList
//
//  Created by Ayşe Nur Bakırcı on 27.07.2021.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    override func awakeFromNib() {
        movieImage.layer.masksToBounds = true
        movieTitle.layer.masksToBounds = true        
    }
    
}
