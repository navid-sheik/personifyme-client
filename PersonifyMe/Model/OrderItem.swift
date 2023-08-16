//
//  OrderItem.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 16/08/2023.
//

import Foundation

enum Status: String, Codable {
        case Processing, Shipped, Delivered, Cancelled, Returned, Refunded
        var descriptionBuyer: String {
            switch self {
                case .Processing:
                    return "Your order is being prepared for shipment. We are working to get it to you as soon as possible."
                case .Shipped:
                    return "Great news! Your order is on its way. You can track the shipment to know exactly when it will arrive."
                case .Delivered:
                    return "Your order has been successfully delivered. We hope you enjoy your purchase!"
                case .Cancelled:
                    return "We’re sorry to hear that you’ve decided to cancel your order. Please let us know how we can assist you further."
                case .Returned:
                    return "We have received your return. Our team is currently processing it, and we'll follow up shortly."
                case .Refunded:
                    return "Your refund has been processed successfully. The funds should be back in your account soon."
                }
           }
}

struct TrackingInfo: Codable {
    let carrier: String
    let trackingNumber: String
    let trackingUrl: String?
}


//For update
struct Tracking : Codable{
    let tracking : TrackingInfo
}
struct OrderItem: Codable {
    let orderId: String
    let product: Product
    let seller: String
    let shippingDetails: Address?
    let userId: String
    let quantity: Int
    let status: Status
    let price: Int
    let variant: [VariantOrder]?
    let customizationOptions: [String]?
    let total: Int
    let createdAt: String?
    let updatedAt: String?
    let tracking: TrackingInfo?
    
    

    enum CodingKeys: String, CodingKey {
        case orderId = "_id"
        case product, seller, shippingDetails, userId, quantity, status, price, variant, customizationOptions, total, createdAt, updatedAt, tracking
    }
}
