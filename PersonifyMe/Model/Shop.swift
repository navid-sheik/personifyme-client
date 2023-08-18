//
//  Shop.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 17/08/2023.
//

import Foundation

struct Shop: Codable {
    let sellerShopID: String?
    let name: String
    let description: String
    let location: String?
    let currecy: String
    let image: String?
    let isActive: Bool
    let categoryId: String
    let categoryName : String
    let emailSupport :  String
    let totalLikes : Int?
    let followers :  [String]?
    let follows: Int?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case sellerShopID = "_id"
        case  name, description, totalLikes,followers, follows,  location, currecy, image, isActive, categoryId, categoryName, emailSupport,  createdAt, updatedAt
    }
}
