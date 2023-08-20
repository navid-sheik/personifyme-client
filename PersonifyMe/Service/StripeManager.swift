//
//  StripeManager.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 19/08/2023.
//

import Foundation



import Foundation

class StripeManager {
    
    /// Convert Stripe's integer amount to a Double.
    /// For most currencies, Stripe represents them in the smallest currency unit (like cents for USD). So, 15000 becomes 150.00.
    static func convertStripeAmountToDouble(_ amount: Int, for currency: String? = nil) -> Double {
        let uppercasedCurrency = currency?.uppercased() ?? "USD"
        switch uppercasedCurrency {
        // Add other currencies that don't typically use 2 decimal places (like JPY)
        case "JPY":
            return Double(amount)
        default:
            return Double(amount) / 100.0
        }
    }
    
    /// Convert a Double value back to Stripe's integer format.
    static func convertDoubleToStripeAmount(_ amount: Double, for currency: String? = nil) -> Int {
        let uppercasedCurrency = currency?.uppercased() ?? "USD"
        switch uppercasedCurrency {
        case "JPY":
            return Int(amount)
        default:
            return Int(amount * 100)
        }
    }
    
    // You can add more utility functions as needed.
}
