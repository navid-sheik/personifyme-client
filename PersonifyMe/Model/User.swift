//
//  User.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation



struct User: Codable {
    let userId: String?
    var image : String?
    var country : String
    var name: String
    var email: String
    let password: String
    var username: String
    let role: String
    var verified: Bool
    let createdAt: String?
    let updatedAt: String?
    let sellerId: String?
    let likes: [String]
    let shopFollowed: [String]

    enum CodingKeys: String, CodingKey {
        case userId = "_id"
        case image 
        case name
        case email
        case country
        case password
        case username
        case role
        case verified
        case createdAt
        case updatedAt
        case sellerId = "seller_id"
        case likes
        case shopFollowed = "shopFollowed"
    }
}
