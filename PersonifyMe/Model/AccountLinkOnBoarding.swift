//
//  AccountLinkOnBoarding.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 20/08/2023.
//

import Foundation

struct AccountLink: Codable {
    let object: String
    let created: Int
    let expiresAt: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case object
        case created
        case expiresAt = "expires_at"
        case url
    }
}
