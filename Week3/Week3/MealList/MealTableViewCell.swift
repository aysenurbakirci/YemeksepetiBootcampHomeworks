//
//  MealTableViewCell.swift
//  Week3
//
//  Created by Ayşe Nur Bakırcı on 9.07.2021.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var cellMealImage: UIImageView!
    @IBOutlet weak var cellMealName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
