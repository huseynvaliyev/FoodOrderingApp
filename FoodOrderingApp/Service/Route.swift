//
//  Route.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 21.08.2021.
//

import Foundation

enum Route {
    
    static let baseURL = "https://www.themealdb.com/api/json/v2/9973533"
    
    case getPopularMeals
    case getChefsMeals
    case getCategories
    case getMealById
    case getCategoryMeals
    
    var description: String {
        switch self {
        case .getPopularMeals:
            return "/latest.php"
        case .getChefsMeals:
            return "/randomselection.php"
        case .getCategories:
            return "/categories.php"
        case .getMealById:
            return "/lookup.php"
        case .getCategoryMeals:
            return "/filter.php"
        }
    }
    
}
