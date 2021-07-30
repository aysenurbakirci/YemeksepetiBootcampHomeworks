//
//  TabBarController.swift
//  CustomTabBarButton
//
//  Created by Ayşe Nur Bakırcı on 30.07.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() { 
        super.viewDidLoad()
        self.setupHomeButton()
    }

    func setupHomeButton() {

        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))

        var homeButtonFrame = homeButton.frame
        homeButtonFrame.origin.y = self.view.bounds.height - homeButtonFrame.height * 1.5
        homeButtonFrame.origin.x = self.view.bounds.width/2 - homeButtonFrame.size.width/2
        homeButton.frame = homeButtonFrame

        homeButton.backgroundColor = UIColor.white
        homeButton.layer.cornerRadius = homeButtonFrame.height/2

        homeButton.setImage(UIImage(named: "homeButton"), for: UIControl.State.normal)
        homeButton.contentMode = .scaleAspectFit
        homeButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: UIControl.Event.touchUpInside)

        self.view.addSubview(homeButton)


        self.view.layoutIfNeeded()
    }

    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }

}

