//
//  OnboardingViewCell.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 12.08.2021.
//

import UIKit

class OnboardingViewCell: UICollectionViewCell {
    
    static let indentifier = String(describing: OnboardingViewCell.self)
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(slide: OnboardingSlide) {
        slideImage.image = slide.image
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
    
}
