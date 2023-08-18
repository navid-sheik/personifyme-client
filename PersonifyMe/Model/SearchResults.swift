//
//  SearchResults.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 18/08/2023.
//

import Foundation


struct SearchResult: Codable {
    let error: Bool
    let total: Int
    let page: Int
    let limit: Int
    let products: [Product]
}
