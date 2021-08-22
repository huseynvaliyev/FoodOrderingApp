//
//  SearchViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 21.08.2021.
//

import UIKit
import ProgressHUD

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var searching = false
    var meals: [Meal] = []
    var searchedMeals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        registerCells()
    }
    
    private func registerCells() {
        searchCollectionView.register(UINib(nibName: MealPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MealPortraitCollectionViewCell.identifier)
    }
    
    private func fetchData() {
        ProgressHUD.show()
        NetworkService.shared.getChefsMels { [weak self] (result) in
            switch result {
            case .success(let mealArray):
                self?.meals = mealArray.meals
                self?.searchCollectionView.reloadData()
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
                print("Error: \(error.localizedDescription)")
            }
        }
        ProgressHUD.dismiss()
    }
    
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            if searchedMeals.count == 0 {
                searchCollectionView.setEmptyView(title: "Sorry, the meal was not found.", message: "Try searching for another meal", messageImage: #imageLiteral(resourceName: "empty"))
            }
            return searchedMeals.count
        } else {
            return meals.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meal: Meal
        if searching {
            meal = searchedMeals[indexPath.item]
        } else {
            meal = meals[indexPath.item]
        }
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: MealPortraitCollectionViewCell.identifier, for: indexPath) as! MealPortraitCollectionViewCell
        cell.setup(meal: meal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meal: Meal
        if searching {
            meal = searchedMeals[indexPath.item]
        } else {
            meal = meals[indexPath.item]
        }
        let controller = self.storyboard?.instantiateViewController(identifier: "MealDetailViewController") as! MealDetailViewController
        controller.mealId = meal.id
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCollectionView.restore()
        searchedMeals = meals.filter({ (meal: Meal) -> Bool in
            return meal.name?.lowercased().contains(searchText.lowercased()) ?? false
        })
        searching = true
        searchCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchCollectionView.reloadData()
        searchCollectionView.restore()
    }
}
