//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by Huseyn Valiyev on 19.08.2021.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    
    func setup(category: MealCategory) {
        categoryTitleLabel.text = category.name
        categoryImageView.kf.setImage(with: URL(string: category.image))
    }
    
    
}
