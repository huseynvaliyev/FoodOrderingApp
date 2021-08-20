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
    var meals: [Meal] = [
        .init(id: "52824", name: "Beef Sunday Roast", image: "https://www.themealdb.com/images/media/meals/ssrrrs1503664277.jpg", country: "British", category: "Beef", instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar."),
        .init(id: "52861", name: "Peanut Butter Cheesecake", image: "https://www.themealdb.com/images/media/meals/qtuuys1511387068.jpg", country: "American", category: "Dessert", instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar."),
        .init(id: "52880", name: "McSinghs Scotch pie", image: "https://www.themealdb.com/images/media/meals/vssrtx1511557680.jpg", country: "British", category: "Lamb", instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        registerCells()
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
        controller.meal = meals[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
