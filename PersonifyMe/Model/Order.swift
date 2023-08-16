//
//  Order.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 15/08/2023.
//

import Foundation

struct VariantOrder: Codable {
    var variant: String
    var value: String
}

//struct OrderItem: Codable {
//    var product: String
//    var seller: String
//    var quantity: Int
//    var status: String
//    var price: Double
//    var variant: [VariantOrder]?
//    var customizationOptions: [String]?
//    var total: Double
//    var expectedDeliveryDate: String?
//    var actualDeliveryDate: String?
//    var trackingNumber: String?
//}

struct Address: Codable {
    var line1: String
    var line2: String?
    var country: String
    var postalCode: String?
    var city: String?
    var state: String?
    var name: String?
    var phone: String?
}
extension Address {
    func formattedAddress() -> String {
        var formattedAddress = ""
        
        if let name = name {
            formattedAddress += "\(name)\n"
        }
        
        if let phone = phone {
            formattedAddress += "\(phone)\n"
        }
        
    
        formattedAddress += "\(line1)\n"
        
        
        if let line2 = line2 {
            formattedAddress += "\(line2)\n"
        }
        
        if let city = city {
            formattedAddress += "\(city), "
        }
        
        formattedAddress += "\(country)"
        
        if let state = state {
            formattedAddress += ", \(state)"
        }
        
        if let postalCode = postalCode {
            formattedAddress += ", \(postalCode)"
        }
        
        return formattedAddress
    }
}

struct Payment: Codable {
    var method: String
    var paymentStatus: String
    var failedReason: String?
    var transactionId: String?
}

struct Order: Codable {
    let orderId: String?
    let userId: String?
    var orderItems: [String]?
    let shippingDetails: Address?
    let transactionId: String?
    var orderStatus: String?
    let orderTotal: Double?
    var taxAmount: Double?
    var shippingCost: Double?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case orderId = "_id"
        case userId, orderItems, shippingDetails, transactionId, orderStatus, orderTotal, taxAmount, shippingCost, createdAt, updatedAt
    }

}

struct OrderCheckout : Codable{
    var paymentIntent: String
    var publishableKey:String
    var payment_intent_id : String
    
    
    
    
}
