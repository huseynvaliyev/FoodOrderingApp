//
//  MealCategory.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 19.08.2021.
//

import Foundation

struct CategoriesRoot: Decodable {
    let categories: [MealCategory]
}

struct MealCategory: Decodable {
    let id: String
    let name: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case image = "strCategoryThumb"
    }
    
}
