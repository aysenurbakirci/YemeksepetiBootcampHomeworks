//
//  RestaurantListViewModel.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 15.08.2021.
//

import Foundation
import FirebaseFirestore

protocol RestaurantListViewModelProtocol {
    
    func load()
    func restaurant(indexPath: Int) -> RestaurantModel?
    func cuisine(indexPath: Int) -> CuisineModel?
    func discount(indexPath: Int) -> String?
    var numberOfItemsRestaurant: Int { get }
    var numberOfItemsCuisine: Int { get }
    var numberOfItemsDiscount: Int { get }
    var delegate: RestaurantListViewModelDelegate? { get set }
}

protocol RestaurantListViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class RestaurantListViewModel {
    
    private var restaurants: [RestaurantModel] = []
    private var cuisines: [CuisineModel] = []
    private var discount: [String] = []
    
    let service: FoodPoolRestaurantServiceProtocol
    weak var delegate: RestaurantListViewModelDelegate?
    init(service: FoodPoolRestaurantServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchRestaurantList() {
        restaurants.removeAll()
        delegate?.showLoadingView()
        service.fetchRestaurants { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let restaurant):
                print(restaurant)
                self.restaurants.append(restaurant)
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func fetchCuisineList() {
        cuisines.removeAll()
        delegate?.showLoadingView()
        service.fetchCuisines { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            switch result {
            case .success(let cuisine):
                print(cuisine)
                self.cuisines.append(cuisine)
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func fetchDiscountImages() {
        discount.removeAll()
        delegate?.showLoadingView()
        service.fetchDiscounts { [weak self] imageName in
            guard let self = self else { return }
            self.delegate?.hideLoadingView()
            print("Image Name: \(imageName)")
            switch imageName {
            case .success(let names):
                self.discount = names.discountImages
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension RestaurantListViewModel: RestaurantListViewModelProtocol {
    
    func load() {
        fetchRestaurantList()
        fetchCuisineList()
        fetchDiscountImages()
    }
    
    func restaurant(indexPath: Int) -> RestaurantModel? {
        restaurants[safe: indexPath]
    }
    
    func cuisine(indexPath: Int) -> CuisineModel? {
        cuisines[safe: indexPath]
    }
    
    func discount(indexPath: Int) -> String? {
        discount[safe: indexPath]
    }
    
    var numberOfItemsRestaurant: Int {
        restaurants.count
    }
    
    var numberOfItemsCuisine: Int {
        cuisines.count
    }
    
    var numberOfItemsDiscount: Int {
        discount.count
    }
}

