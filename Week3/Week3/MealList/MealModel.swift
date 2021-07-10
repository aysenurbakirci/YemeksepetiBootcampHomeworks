//
//  MealModel.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 10.07.2021.
//

import Foundation
import UIKit

class MealModel {
    
    var mealName = String()
    var mealImage = UIImage()
    
    init(mealName: String, mealImage: UIImage) {
        
        self.mealName = mealName
        self.mealImage = mealImage
        
    }
    
}
