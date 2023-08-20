//
//  Seller.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation

enum ShopIdentifier: Codable {
    case string(String)
    case shop(Shop)
    
    // MARK: - Codable Conformance
    init(from decoder: Decoder) throws {
        if let shop = try? Shop(from: decoder) {
            self = .shop(shop)
        } else if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Failed to decode ShopIdentifier"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let string):
            try container.encode(string)
        case .shop(let shop):
            try container.encode(shop)
        }
    }
}
struct Seller: Codable {
    let id, userId, stripeAccountID: String
    let isVerified, hasStartedOnboarding, hasCompletedOnboarding: Bool
    let originCountry: String
    let shopId : ShopIdentifier?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case stripeAccountID = "stripe_account_id"
        case isVerified = "is_verifed"
        case hasStartedOnboarding, hasCompletedOnboarding
        case originCountry = "origin_country"
        case shopId
        case createdAt
        case updatedAt
        
    }
}
