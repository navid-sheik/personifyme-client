//
//  Cart.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 13/08/2023.
//

import Foundation


struct Cart: Codable {
    let cartId: String
    let userId: String
    var items: [CartItem]

    enum CodingKeys: String, CodingKey {
        case cartId = "_id"
        case userId, items
    }
}

struct ProductCartInfo : Codable{
    let productId: String
    let productImages : [String]
    let productTitle : String
    let shopName : String?
    
    enum CodingKeys: String, CodingKey {
        case productId = "_id"
        case productImages = "images"
        case productTitle = "title"
        case shopName
        
       
    }
    

}

struct CartItem: Codable {
    let productId: ProductCartInfo
    var quantity: Int
    let price: Double
    let hasVariations: Bool

    let variations: [VariantCart]
    let customizationOptions: [String]
    
    // Properties specific to data from the server:
    let cartItemId: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case cartItemId = "_id"
        case productId, quantity, price, hasVariations, variations, customizationOptions, createdAt, updatedAt
    }
}

struct CartItemSend: Codable {
    let productId: String
    let quantity: Int
    let price: Double
    let hasVariations: Bool

    let variations: [VariantCart]
    let customizationOptions: [String]
    
    // Properties specific to data from the server:
    let cartItemId: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case cartItemId = "_id"
        case productId, quantity, price, hasVariations, variations, customizationOptions, createdAt, updatedAt
    }
}

struct VariantCart: Codable {
    let variant: String
    let value: String
}



extension Cart {
    var totalPrice: Double {
        let total = items.reduce(0) { total, item in
            total + item.totalPrice
        }
        return (total * 100).rounded() / 100
    }
}

extension CartItem {
    var totalPrice: Double {
        return price * Double(quantity)
    }
    var totalPriceRounded: Double {
            let total = price * Double(quantity)
            return (total * 100).rounded() / 100
        }
}

