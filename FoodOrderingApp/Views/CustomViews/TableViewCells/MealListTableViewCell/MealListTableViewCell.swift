//
//  MealListTableViewCell.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 20.08.2021.
//

import UIKit

class MealListTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: MealListTableViewCell.self)
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealCountryLabel: UILabel!
    
    func setup(meal: Meal) {
        mealImage.kf.setImage(with: URL(string: meal.image))
        mealNameLabel.text = meal.name
        mealCountryLabel.text = meal.country
    }
    
}
