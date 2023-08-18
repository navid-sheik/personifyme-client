//
//  Category.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation
// MARK: - CategoryID
struct Category: Codable {
    let categoryId,  name, description: String
    let parent : String?

    enum CodingKeys: String, CodingKey {
        case categoryId = "_id"
        case name, description, parent
    }
}
