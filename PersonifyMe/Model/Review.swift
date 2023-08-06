//
//  Review.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation


struct Review: Codable {
    let reviewId: String
    let productId: String
    let rating: Int
    let  text: String?
    let username : String
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case reviewId = "_id"
        case productId , username,  rating, text
        case createdAt, updatedAt
    }
}
