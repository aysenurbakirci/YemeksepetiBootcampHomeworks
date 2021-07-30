//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Ayşe Nur Bakırcı on 29.07.2021.
//

import UIKit
import SDWebImage
import Alamofire
import CoreData
import Toast

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var likeButton: UIBarButtonItem!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var movie: MovieModel?
    var isFavoriteMovie = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFavoriteMovie {
            likeButton.image = UIImage(systemName: "star.fill")
        } else {
            likeButton.image = UIImage(systemName: "star")
        }

        movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w200\(movie?.poster ?? "")"), placeholderImage: UIImage(named: "defaultImage"))
        movieName.text = movie?.title ?? "Game Name"
        voteCount.text = String(movie?.vote ?? 0)
        
        getMovieOverview(movieID: movie?.id ?? 0)
        movieDescription.numberOfLines = 0
        movieDescription.lineBreakMode = .byWordWrapping
        movieDescription.frame.size.width = 300
        movieDescription.sizeToFit()
        
    }
    
    @IBAction func likeButtonClick(_ sender: Any) {
        
        if isFavoriteMovie {
            likeButton.image = UIImage(systemName: "star")
            isFavoriteMovie = false
            removeFavoriteList(id: movie?.id ?? 0)
        } else {
            likeButton.image = UIImage(systemName: "star.fill")
            isFavoriteMovie = true
            addFavoriteList(id: movie?.id ?? 0)
        }
    }

    private func addFavoriteList(id: Int) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let newGameID = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovies", into: context)
        newGameID.setValue(movie?.id, forKey: "movieID")

        do {
            try context.save()
            self.view.makeToast("Movie is your favorites list now.", duration: 3.0, position: .top)
        } catch {
            self.view.makeToast("The movie could not be added to your favorites list.", duration: 3.0, position: .top)
        }

    }
    
    private func removeFavoriteList(id: Int) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let id = result.value(forKey: "movieID")as? Int else { return }
                    if id == movie?.id{
                        context.delete(result)
                    }
                }
                try context.save()
                self.view.makeToast("We're so sorry you don't like this movie anymore.", duration: 3.0, position: .top)
            }
        } catch {
            print("Error")
            self.view.makeToast("Movie could not be removed from favorites.", duration: 2.0, position: .top)
        }
    }
    
    private func getMovieOverview(movieID: Int) {
        spinner.startAnimating()
        spinner.isHidden = false
        
        AF.request("https://api.themoviedb.org/3/movie/\(movieID)?language=en-%20US&api_key=fd2b04342048fa2d5f728561866ad52a").responseJSON { [self] response in
            
            switch response.result {
            
            case .success(let jsonData):
                if let response = jsonData as? Dictionary<String,Any> {
                    print(response["overview"] ?? "Overview")
                    self.movieDescription.text = response["overview"] as? String
                }else{
                    print("JSON parse error")
                }
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
            }
        }
    }

}
