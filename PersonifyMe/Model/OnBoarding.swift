//
//  OnBoarding.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 20/08/2023.
//

import Foundation
// Stripe account data

struct OnBoardingData: Codable {
    let stripeId: String
    let business_type: String?
    let capabilities: CapabilitiesOnBording
    let charges_enabled: Bool
    let country: String
    let default_currency: String
    let payouts_enabled: Bool
    let requirements: RequirementsOnBoarding
    
    enum CodingKeys: String, CodingKey {
        case stripeId = "id"
        case business_type, capabilities, charges_enabled, country, default_currency, payouts_enabled, requirements
    }

}

// Capabilities
struct CapabilitiesOnBording: Codable {
    let card_payments: String
    let transfers: String
}

// Requirements
struct RequirementsOnBoarding: Codable {
    let alternatives : [String]
    let current_deadline: Int?
    let currently_due: [String]
    let disabled_reason: String?
    let errors: [String]
    let eventually_due: [String]
    let past_due: [String]
    let pending_verification: [String]
}
