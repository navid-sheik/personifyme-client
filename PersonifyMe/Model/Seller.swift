//
//  Seller.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation
struct Seller: Codable {
    let id, userId, stripeAccountID: String
    let isVerified, hasStartedOnboarding, hasCompletedOnboarding: Bool
    let originCountry: String
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case stripeAccountID = "stripe_account_id"
        case isVerified = "is_verified"
        case hasStartedOnboarding, hasCompletedOnboarding
        case originCountry = "origin_country"
        case createdAt
        case updatedAt
    }
}
