//
//  PageViewController.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 8.07.2021.
//

import UIKit

class PageViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .clear
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        //page controlün sayfa değişikliklerini takıp etmesi
        pageControl.addTarget(self, action: #selector(pageControlChange(_:)), for: .valueChanged)
        scrollView.backgroundColor = .red
        view.addSubview(scrollView)
        view.addSubview(pageControl)
    }
    
    @objc private func pageControlChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.size.width, y: 0), animated: true)
    }
    
    //Ekran görünmeden önce sınırları, konumları ve boyutları ayarlamak içın kullanılır.
    override func viewDidLayoutSubviews() {
        pageControl.frame = CGRect(x: 10, y: view.frame.size.height - 100, width: view.frame.size.width - 20 , height: 70)
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        if scrollView.subviews.count == 2 {
            scrollViewConfiguration()
        }
    }

    //Page controlde gösterilecek görünümler
    private func scrollViewConfiguration() {
        scrollView.contentSize = CGSize(width: view.frame.size.width * 3, height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        let colorList: [UIColor] = [.red, .green, .blue]
        
        for i in 0..<3 {
            let page = UIView(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.width, height: scrollView.frame.height))
            page.backgroundColor = colorList[i]
            scrollView.addSubview(page)
        }
    }
}
//Sayfa kaydırılarak değiştiğinde de sayfa değişikliğinin kontrolünün sağlanması
extension PageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x / scrollView.frame.size.width)))
    }
}
