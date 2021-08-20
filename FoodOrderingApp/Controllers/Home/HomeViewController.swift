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
    
    var categories: [MealCategory] = [
        .init(id: "1", name: "Beef", image: "https://www.themealdb.com/images/category/beef.png"),
        .init(id: "2", name: "Chicken", image: "https://www.themealdb.com/images/category/chicken.png"),
        .init(id: "3", name: "Dessert", image: "https://www.themealdb.com/images/category/dessert.png"),
        .init(id: "4", name: "Lamb", image: "https://www.themealdb.com/images/category/lamb.png"),
        .init(id: "4", name: "Lamb", image: "https://www.themealdb.com/images/category/lamb.png")
    ]
    
    var popularMeals: [Meal] = [
        .init(id: "53062", name: "Walnut Roll Gužvara", image: "https://www.themealdb.com/images/media/meals/u9l7k81628771647.jpg", country: "Croatian", category: "Dessert",instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar."),
        .init(id: "53061", name: "Fresh sardines", image: "https://www.themealdb.com/images/media/meals/nv5lf31628771380.jpg", country: "Croatian", category: "Side", instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar."),
        .init(id: "53060", name: "Burek", image: "https://www.themealdb.com/images/media/meals/tkxquw1628771028.jpg", country: "Croatian", category: "Side",instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar."),
        .init(id: "53059", name: "Mushroom soup with buckwheat", image: "https://www.themealdb.com/images/media/meals/1ngcbf1628770793.jpg", country: "Croatian", category: "Side",instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar.")
    ]
    
    var chefsMeals: [Meal] = [
        .init(id: "52824", name: "Beef Sunday Roast", image: "https://www.themealdb.com/images/media/meals/ssrrrs1503664277.jpg", country: "British", category: "Beef", instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar."),
        .init(id: "52861", name: "Peanut Butter Cheesecake", image: "https://www.themealdb.com/images/media/meals/qtuuys1511387068.jpg", country: "American", category: "Dessert", instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar."),
        .init(id: "52880", name: "McSinghs Scotch pie", image: "https://www.themealdb.com/images/media/meals/vssrtx1511557680.jpg", country: "British", category: "Lamb", instruction: "Mix all the ingredients for the dough together and knead well. Cover the dough and put to rise until doubled in size which should take about 2 hours. Knock back the dough and knead lightly. Divide the dough into two equal pieces; roll each piece into an oblong about 12 inches by 8 inches. Mix the filling ingredients together and divide between the dough, spreading over each piece. Roll up the oblongs as tightly as possible to give two 12 inch sausages. Place these side by side, touching each other, on a greased baking sheet. Cover and leave to rise for about 40 minutes. Heat oven to 200ºC (425ºF). Bake for 30-35 minutes until well risen and golden brown. Bread should sound hollow when the base is tapped. Remove from oven and brush the hot bread top with milk. Sift with a generous covering of icing sugar.")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
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
            
        } else {
            let controller = self.storyboard?.instantiateViewController(identifier: "MealDetailViewController") as! MealDetailViewController
            controller.meal = collectionView == popularCollectionView ? popularMeals[indexPath.item] : chefsMeals[indexPath.item]
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}
