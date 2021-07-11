//
//  MealModel.swift
//  MealList
//
//  Created by Ayşe Nur Bakırcı on 11.07.2021.
//

import Foundation
import UIKit

class MealModel {
    
    var mealID = UUID()
    var mealName = String()
    var mealImage = UIImage()
    
    init(mealName: String, mealImage: UIImage, mealID: UUID) {
        
        self.mealName = mealName
        self.mealImage = mealImage
        self.mealID = mealID
        
    }
}

