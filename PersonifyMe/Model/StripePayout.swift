//
//  StripePayout.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 19/08/2023.
//

import Foundation
struct StripePayout: Codable {
    let payouts: [StripePayoutDetail]
    let totalBalancePaidOut: Int
    let totalPendingPayouts: Int
}

struct StripePayoutDetail: Codable {
    let amount: Int
    let arrivalDate: Int
    let currency: String
    let status: String
    let reconciliationStatus: String
    let failureMessage: String?
    let bankAccountDetails: BankAccountDetails
    
    enum CodingKeys: String, CodingKey {
        case amount, arrivalDate = "arrival_date", currency, status
        case reconciliationStatus = "reconciliation_status"
        case failureMessage = "failure_message"
        case bankAccountDetails = "bankAccountDetails"
    }
}

struct BankAccountDetails: Codable {
    let bankName: String
    let country: String
    let currency: String
    let last4: String
    let routingNumber: String
    
    enum CodingKeys: String, CodingKey {
        case bankName = "bank_name"
        case country, currency, last4
        case routingNumber = "routing_number"
    }
}
