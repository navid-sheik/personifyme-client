//
//  StripeStatusResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation

struct StripeStatusResponse: Codable {
    let isVerified: Bool
    let payoutsEnabled: Bool
    let chargesEnabled: Bool
    let requirements: Requirements
    
    enum CodingKeys: String, CodingKey {
        case isVerified = "isVerified"
        case payoutsEnabled = "payouts_enabled"
        case chargesEnabled = "charges_enabled"
        case requirements
    }
}

struct Requirements: Codable {
    let currentlyDue: [String]
    let eventuallyDue: [String]
    let pastDue: [String]
    let currentDeadline: String?
    let disabledReason: String?
    let errors: [String]
    
    enum CodingKeys: String, CodingKey {
           case currentlyDue = "currently_due"
           case eventuallyDue = "eventually_due"
           case pastDue = "past_due"
           case currentDeadline = "current_deadline"
           case disabledReason = "disabled_reason"
           case errors
       }
    
}
