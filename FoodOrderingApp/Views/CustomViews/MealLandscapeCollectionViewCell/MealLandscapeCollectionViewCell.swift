//
//  MealLandscapeCollectionViewCell.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 20.08.2021.
//

import UIKit
import Kingfisher

class MealLandscapeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: MealLandscapeCollectionViewCell.self)
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var mealCountryLabel: UILabel!
    
    func setup(meal: Meal) {
        mealNameLabel.text = meal.name
        mealCategoryLabel.text = meal.category
        mealCountryLabel.text = meal.country
        mealImage.kf.setImage(with: URL(string: meal.image ?? ""))
    }
    
}
