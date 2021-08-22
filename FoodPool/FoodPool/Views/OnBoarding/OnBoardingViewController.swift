//
//  SwipeViewController.swift
//  FoodPool
//
//  Created by Ayşe Nur Bakırcı on 9.08.2021.
//

import UIKit

class OnBoardingViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let pageModels = [
        OnBoardingUIModel(imageName: "onBoardingHamburger", title: "Quick Order!", description: "If you're hungry and don't have time prepare a food, you can easly order food from this application. You just decide what you wat to eat and than you can order just 5 click."),
        OnBoardingUIModel(imageName: "onBoardingFries", title: "Delicious Meal!", description: "Have you decide what you want to eat, now you can find delicious one food. Our application has a rating system so you can see your restaurant point about how delicious foods."),
        OnBoardingUIModel(imageName: "onBoardingDrink", title: "Happy Human!", description: "You had ordered your food and you found the delicious one. It was easy and quick for you. Enjoy easily reaching food.")
    
    ]
    
    private lazy var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageModels.count
        pageControl.currentPageIndicatorTintColor = .mainOrange
        pageControl.pageIndicatorTintColor = .mainLightOrange
        return pageControl
    }()
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int( x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingPageCell.reuseIdentifier, for: indexPath) as! OnboardingPageCell
        cell.configuration(with: pageModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    private func configuration() {
        view.addSubview(pageControl)
        pageControl.anchor(top: nil, leading: self.view.leadingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, trailing: self.view.trailingAnchor)
        pageControl.anchorSize(size: .init(width: self.view.frame.width, height: 50.0))
        
        collectionView.backgroundColor = .white
        collectionView.register(OnboardingPageCell.self, forCellWithReuseIdentifier: OnboardingPageCell.reuseIdentifier)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}
