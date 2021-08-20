//
//  ApiResponse.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 21.08.2021.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
