//
//  ViewController.swift
//  MovieList
//
//  Created by Ayşe Nur Bakırcı on 27.07.2021.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var gridListSwitchButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var gridLayout = GridLayout()
    private var listLayout = ListLayout()
    
    private var movieList: [MovieModel] = []
    private var filteredMovieList: [MovieModel] = []
    private var favoriteMovieIDList: [Int] = []
    
    private var pageNumber: Int = 1
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    private var isSearchBarEmpty: Bool {
        let searchText = searchController.searchBar.text
        return searchText?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private var isGridLayoutUsed: Bool = false {
        didSet {
            updateButtonAppearance()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = gridLayout
        collectionView.dataSource = self
        isGridLayoutUsed = true
        gridListSwitchButton.tintColor = .black
        searchControllerConfiguration()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        pageNumber = 1
        movieList.removeAll()
        getMovieList(pageNumber: pageNumber)
        getFavoriteMovies()
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changeCellDesign(_ sender: Any) {
        
        isGridLayoutUsed = !isGridLayoutUsed
        
        if isGridLayoutUsed {
            gridListSwitchButton.image = UIImage(systemName: "rectangle.grid.1x2.fill")
            gridListSwitchButton.tintColor = .black
        } else {
            gridListSwitchButton.image = UIImage(systemName: "square.grid.2x2.fill")
            gridListSwitchButton.tintColor = .black
        }
    }
    
    fileprivate func updateButtonAppearance() {
        let layout = isGridLayoutUsed ? gridLayout : listLayout
        UIView.animate(withDuration: 0.4) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    
}

extension ViewController {
    
    private func getMovieList(pageNumber: Int) {
        spinner.startAnimating()
        spinner.isHidden = false
        
        AF.request("https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=\(pageNumber)").responseJSON { [self] response in
            
            switch response.result {
            
            case .success(let jsonData):
                if let response = jsonData as? Dictionary<String,Any> {
                    if let movieList = response["results"] as? [[String : Any]] {
                        for movie in movieList {
                            let mappingMovie = Mapper<MovieModel>().map(JSON: movie)
                            self.movieList.append(mappingMovie!)
                            self.collectionView.reloadData()
                        }
                    } else {
                        print("Json mapping error")
                    }
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
    
    private func getFavoriteMovies () {
        
        favoriteMovieIDList.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    guard let movieID = result.value(forKey: "movieID") as? Int else {
                        return
                    }
                    favoriteMovieIDList.append(movieID)
                }
            }
        } catch{
            print("Error")
        }
        
    }
    
    private func isFavoriteMovie(movieID: Int) -> Bool {
        for id in favoriteMovieIDList {
            if movieID == id {
                return true
            }
        }
        return false
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            if filteredMovieList.count == 0 {
                self.collectionView.setEmptyMessage("Movie Was Not Found.")
            } else {
                self.collectionView.restore()
            }
            return filteredMovieList.count
        }
        self.collectionView.restore()
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie: MovieModel
        
        if isFiltering {
            movie = filteredMovieList[indexPath.row]
        } else {
            movie = movieList[indexPath.row]
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell {
            
            cell.movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w200\(movie.poster ?? "")"), placeholderImage: UIImage(named: "defaultImage"))
            cell.movieTitle.text = movie.title ?? "Movie Name"
            
            if isFavoriteMovie(movieID: movie.id ?? 0) {
                cell.starImage.image = UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
                cell.starImage.tintColor = .yellow
            } else {
                cell.starImage.image = UIImage(named: "")
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movieList[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "MovieDetailViewController") as! MovieDetailViewController
        
        vc.movie = movie
        
        if isFavoriteMovie(movieID: movie.id ?? 0){
            vc.isFavoriteMovie = true
        } else {
            vc.isFavoriteMovie = false
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageNumber = pageNumber + 1
        if indexPath.row == movieList.count - 1 {
            getMovieList(pageNumber: pageNumber)
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContextForSearchText(searchText: searchBar.text!)
    }
    
    private func searchControllerConfiguration() {
        
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search Game"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    func filterContextForSearchText(searchText: String) {
        filteredMovieList = movieList.filter({ (movie: MovieModel) -> Bool in
            return (movie.title?.lowercased().contains(searchText.lowercased()))!
        })
        collectionView.reloadData()
    }
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
    
}
