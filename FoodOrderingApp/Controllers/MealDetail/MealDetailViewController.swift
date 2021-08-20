//
//  MealDetailViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 20.08.2021.
//

import UIKit
import Kingfisher

class MealDetailViewController: UIViewController {
    
    var meal: Meal!
    var mealId: String!
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var addtoCartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addtoCartButton.layer.cornerRadius = 8
        DispatchQueue.main.async {
            NetworkService.shared.getMealById(id: self.mealId) { [weak self] (result) in
                switch result {
                case .success(let mealArray):
                    self?.meal = mealArray.meals.first
                    self?.populateView()
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func populateView() {
        mealImageView.kf.setImage(with: URL(string: meal.image ?? ""))
        mealNameLabel.text = meal.name
        mealCategoryLabel.text = meal.category
    }
    
    @IBAction func countStepperTapped(_ sender: UIStepper) {
        countTextField.text = Int(sender.value).description
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        
    }
    
}
