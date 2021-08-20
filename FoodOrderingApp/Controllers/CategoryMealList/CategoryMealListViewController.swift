//
//  CategoryMealListViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 20.08.2021.
//

import UIKit

class CategoryMealListViewController: UIViewController {
    
    @IBOutlet weak var mealListTableView: UITableView!
    
    var category: MealCategory!
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCells()
        NetworkService.shared.getMealsByCategory(category: category.name) { [weak self] (result) in
            switch result {
            case .success(let mealArray):
                self?.meals = mealArray.meals
                self?.mealListTableView.reloadData()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func registerCells() {
        mealListTableView.register(UINib(nibName: MealListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MealListTableViewCell.identifier)
    }
    
}

extension CategoryMealListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mealListTableView.dequeueReusableCell(withIdentifier: MealListTableViewCell.identifier, for: indexPath) as! MealListTableViewCell
        cell.setup(meal: meals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(identifier: "MealDetailViewController") as! MealDetailViewController
        controller.mealId = meals[indexPath.row].id
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
