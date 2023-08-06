//
//  Category.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation
// MARK: - CategoryID
struct Category: Codable {
    let id, name, description: String
    let parent : String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, description, parent
    }
}
