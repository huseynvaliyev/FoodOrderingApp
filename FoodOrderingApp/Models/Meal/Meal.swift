//
//  Meal.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 20.08.2021.
//

import Foundation

struct Meal: Decodable {
    
    let id: String
    let name: String
    let image: String
    let country: String
    let category: String
    let instruction: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case image = "strMealThumb"
        case country = "strArea"
        case category = "strCategory"
        case instruction = "strInstructions"
    }
    
}
