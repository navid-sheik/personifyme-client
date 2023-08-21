//
//  SavedStripePayment.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 21/08/2023.
//

import Foundation
struct PaymentMethod: Codable {
    let paymentId: String
    let billingDetails: BillingDetailsStripe
    let card: CardStripe
    
    enum CodingKeys: String, CodingKey {
        case paymentId = "id"
        case billingDetails = "billing_details"
        case card
    }
}

struct BillingDetailsStripe: Codable {
    let address: AddressSaveStripe
    
    enum CodingKeys: String, CodingKey {
        case address
    }
}

struct AddressSaveStripe: Codable {
    let country: String
    let postalCode: String
    
    enum CodingKeys: String, CodingKey {
        case country
        case postalCode = "postal_code"
    }
}

struct CardStripe: Codable {
    let expMonth: Int
    let expYear: Int
    let last4: String
    let country: String
    
    enum CodingKeys: String, CodingKey {
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case last4
        case country
    }
}
