//
//  SearchQuery.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 18/08/2023.
//

import Foundation


struct SearchQuery: Codable {
    let searchId: String
    let query: String
    let count: Int
    let createdAt: String?
    let updatedAt: String?
    
    
    enum CodingKeys: String, CodingKey {
        case searchId = "_id"
        case query, count, createdAt, updatedAt
    }

    
}
