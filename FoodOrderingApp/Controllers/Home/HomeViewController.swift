//
//  HomeViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 18.08.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var chefSpecialsCollectionView: UICollectionView!
    
    var categories: [MealCategory] = []
    
    var popularMeals: [Meal] = []
    
    var chefsMeals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        fetchData()
    }
    
    private func fetchData() {
        let dispachGroup = DispatchGroup()
        dispachGroup.enter()
        NetworkService.shared.getPopularMeal { [weak self] (result) in
            switch result {
            case .success(let popular):
                self?.popularMeals = popular.meals
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispachGroup.leave()
        }
        dispachGroup.enter()
        NetworkService.shared.getChefsMels { [weak self] (result) in
            switch result {
            case .success(let chefs):
                self?.chefsMeals = chefs.meals
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispachGroup.leave()
        }
        dispachGroup.enter()
        NetworkService.shared.getCategories { [weak self] (result) in
            switch result{
            case .success(let categoryArray):
                self?.categories = categoryArray.categories
            case.failure(let error):
                print(error.localizedDescription)
            }
            dispachGroup.leave()
        }
        dispachGroup.notify(queue: .main) {
            self.popularCollectionView.reloadData()
            self.chefSpecialsCollectionView.reloadData()
            self.categoryCollectionView.reloadData()
        }
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: MealPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MealPortraitCollectionViewCell.identifier)
        chefSpecialsCollectionView.register(UINib(nibName: MealLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MealLandscapeCollectionViewCell.identifier)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return popularMeals.count
        case chefSpecialsCollectionView:
            return chefsMeals.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.item])
            return cell
        case popularCollectionView:
            let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: MealPortraitCollectionViewCell.identifier, for: indexPath) as! MealPortraitCollectionViewCell
            cell.setup(meal: popularMeals[indexPath.item])
            return cell
        case chefSpecialsCollectionView:
            let cell = chefSpecialsCollectionView.dequeueReusableCell(withReuseIdentifier: MealLandscapeCollectionViewCell.identifier, for: indexPath) as! MealLandscapeCollectionViewCell
            cell.setup(meal: chefsMeals[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = self.storyboard?.instantiateViewController(identifier: "CategoryMealListViewController") as! CategoryMealListViewController
            controller.category = categories[indexPath.item]
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let controller = self.storyboard?.instantiateViewController(identifier: "MealDetailViewController") as! MealDetailViewController
            controller.mealId = collectionView == popularCollectionView ? popularMeals[indexPath.item].id : chefsMeals[indexPath.item].id
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
