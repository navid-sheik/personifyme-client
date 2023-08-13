//
//  Product.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation


// MARK: - Product
struct Product: Codable {
    let productId, title, description: String
    let sellerId: Seller
    let price: Double
    let categoryId: Category
    let customizationOptions: [CustomizationOption]
    let sold: Int
    let quantity : Int
    let images: [String]
    let status: String
    let isDeleted: Bool
    let condition: String
    let hasVariations: Bool
    let variations: [Variation]? // Optional, as there may not be variations
    let shippingInfo: ShippingInfo
    let returnPolicy, shippingPolicy: Bool
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case productId = "_id"
        case title, description
        case sellerId = "seller_id"
        case price
        case quantity
        case categoryId = "category_id"
        case customizationOptions = "customizationOptions"
        case sold, images, status
        case isDeleted = "isDeleted"
        case condition
        case hasVariations = "hasVariations"
        case variations
        case shippingInfo = "shippingInfo"
        case returnPolicy = "returnPolicy"
        case shippingPolicy = "shippingPolicy"
        case createdAt, updatedAt
    }
}



//MARK: -CustomizationOption
struct CustomizationOption: Codable{
    let id : String
    let field : String
    let instructions : String
    let customizationType : String
   
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case field
        case instructions
        case customizationType
        
    }
}


// MARK: - ShippingInfo




struct ShippingInfo: Codable {
    let processingTime: ProcessingTime
    let originCountry, destinationCountry: String
    let internationalDelivery : Delivery?
    let standardDelivery: Delivery

    enum CodingKeys: String, CodingKey {
        case processingTime, originCountry, destinationCountry
        case internationalDelivery, standardDelivery
    }
}

// MARK: - Delivery
struct Delivery: Codable {
    let deliveryTime: ProcessingTime
    let available: Bool

    enum CodingKeys: String, CodingKey {
        case deliveryTime, available
    }
}

// MARK: - ProcessingTime
struct ProcessingTime: Codable {
    let min, max: Int
}

// MARK: - Variation
struct Variation: Codable {
    let id: String
    let name: String
    let options: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, options
    }
}

// MARK: - Option
struct Option: Codable {
    let id: String
    let name: String
    let quantity: Int?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, quantity, price
    }
}



struct ProductListing: Codable {
    let title, description: String
    let price: Double
    let quantity : Int
    let category_id: String
    let customizationOptions: [CustomizationOptionListing]
    var images: [String]
    let condition: String
    let hasVariations: Bool
    let variations: [Variant]? // Optional, as there may not be variations
    let shippingInfo: ShippingInfo
    let returnPolicy, shippingPolicy: Bool
}


struct CustomizationOptionListing: Codable{
    
    let field : String
    let instructions : String
    let customizationType : String
    
   
    
    
    
}
