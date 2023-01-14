//
//  Recipe.swift
//  Recipe Master
//
//  Created by Nisitha on 1/8/23.
//

import Foundation

struct RecipesListResponse: Codable {
    let data:[Recipe]
}

struct Recipe: Codable{
    let ingredients: String?
    let calorie_count: Double
    let created_at: String?
    let description: String?
    let id: Int
    let image: String?
    let name: String?
    let updated_at: String?
}

