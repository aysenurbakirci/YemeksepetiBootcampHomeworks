//
//  ViewController.swift
//  Movies
//
//  Created by Kerim Caglar on 3.08.2021.
//

import UIKit
import NetworkAPI

extension ViewController {
    
    fileprivate enum Constants {
        static let cellTitleHeight: CGFloat = 50
        static let cellPosterImageRatio: CGFloat = 1/2
        static let cellLeftPadding: CGFloat = 15
        static let cellRightPadding: CGFloat = 15
    }
}

class ViewController: UIViewController, LoadingShowable {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    let service: MovieServiceProtocol = PopularMoviesService()
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }

    fileprivate func fetchMovies() {
        showLoading()
        service.fetchPopularMovies { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading()
            switch result {
            case .success(let movies):
                print(movies)
                self.movies = movies
                self.movieCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let movie = self.movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.movieModel = movie
        return cell
        
    }
    
    private func calculateHeight() -> CGFloat {
        
        let cellWidht = view.frame.size.width - 20
        let posterImageHeight = cellWidht * Constants.cellPosterImageRatio
        
        return Constants.cellTitleHeight + posterImageHeight
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movies[indexPath.row].title)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.size.width - 20, height: calculateHeight())
    }
}
