//
//  TabBarController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 11.08.2021.
//

import UIKit
import FontAwesome

class TabBarController: UITabBarController {
    
    let homePage = RestaurantListViewController()
    let homeViewModel = RestaurantListViewModel(service: FoodPoolServices())
    
    let basketPage = BasketViewController()
    let basketViewModel = BasketViewModel()
    
    let orderPage = OrderViewController()
    let orderViewModel = OrderViewModel(service: FoodPoolServices())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePage.restaurantListViewModel = homeViewModel
        let controllerHome = UINavigationController(rootViewController: homePage)
        
        basketPage.basketViewModel = basketViewModel
        let controllerBasket = UINavigationController(rootViewController: basketPage)
        
        orderPage.orderViewModel = orderViewModel
        let controllerOrder = UINavigationController(rootViewController: orderPage)
        
        
        homePage.title = "Home"
        basketPage.title = "Basket"
        orderPage.title = "Order"
        
        let homeImage = UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: .black, size: CGSize(width: 30.0, height: 30.0))
        let basketImage = UIImage.fontAwesomeIcon(name: .shoppingBasket, style: .solid, textColor: .black, size: CGSize(width: 30.0, height: 30.0))
        let orderImage = UIImage.fontAwesomeIcon(name: .utensils, style: .solid, textColor: .black, size: CGSize(width: 30.0, height: 30.0))
        
        let imageList = [homeImage, basketImage, orderImage]

        setViewControllers([controllerHome, controllerBasket, controllerOrder], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        for index in 0..<items.count {
            items[index].image = imageList[index]
        }
        tabBarConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        openOnboardingScreen()
    }
    
    private func openOnboardingScreen() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let rootVC = OnBoardingViewController(collectionViewLayout: layout)
        let navigation = UINavigationController(rootViewController: rootVC)
        navigation.isNavigationBarHidden = true
        present(navigation, animated: true, completion: nil)
        
    }
    
    private func tabBarConfiguration () {
        
        self.tabBar.tintColor = .mainOrange
        self.tabBar.layer.cornerRadius = 40
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.layer.shadowOffset = CGSize.zero
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.tabBar.layer.shadowRadius = CGFloat(10.0)
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
    }
}
