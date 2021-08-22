//
//  RestaurantFilterViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 21.08.2021.
//

import Foundation

protocol RestaurantFilterViewModelProtocol {
    
    func load()
    func restaurant(indexPath: Int) -> RestaurantModel?
    var numberOfItemsRestaurant: Int { get }
    var delegate: RestaurantFilterViewModelDelegate? { get set }
}

protocol RestaurantFilterViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func filterCategory() -> String
}

final class RestaurantFilterViewModel {
    
    private var filteredRestaurants: [RestaurantModel] = []
    let service: FoodPoolRestaurantServiceProtocol
    weak var delegate: RestaurantFilterViewModelDelegate?
    
    init(service: FoodPoolRestaurantServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchRestaurantList() {
        filteredRestaurants.removeAll()
        let selectedCategory = self.delegate?.filterCategory()
        delegate?.showLoadingView()
        service.fetchRestaurants { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let restaurant):
                print(restaurant)
                if restaurant.restaurantCuisineType == selectedCategory {
                    self.filteredRestaurants.append(restaurant)
                    self.delegate?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RestaurantFilterViewModel: RestaurantFilterViewModelProtocol {
    
    func restaurant(indexPath: Int) -> RestaurantModel? {
        filteredRestaurants[safe: indexPath]
    }
    
    var numberOfItemsRestaurant: Int {
        filteredRestaurants.count
    }
    
    func load() {
        fetchRestaurantList()
    }
}
