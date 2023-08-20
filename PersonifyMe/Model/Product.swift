//
//  Product.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation

import UIKit


enum SellerIdentifier: Codable {
    case string(String)
    case seller(Seller)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Debugging
        print("Debug container: \(container)")
        
        // Try to decode as a String
        if let idString = try? container.decode(String.self) {
            self = .string(idString)
            return
        }
        
        // Try to decode as a Seller object
        if let sellerObject = try? container.decode(Seller.self) {
            self = .seller(sellerObject)
            return
        }
        
        // Debugging
        print("Failed to decode either as String or Seller object.")
        
        throw DecodingError.typeMismatch(SellerIdentifier.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Mismatched Types"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let idString):
            try container.encode(idString)
        case .seller(let sellerObject):
            try container.encode(sellerObject)
        }
    }
}

enum CategoryIdentifier: Codable {
    case string(String)
    case category(Category)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Try to decode as a String
        if let idString = try? container.decode(String.self) {
            self = .string(idString)
            return
        }
        
        // Try to decode as a Category object
        if let categoryObject = try? container.decode(Category.self) {
            self = .category(categoryObject)
            return
        }
        
        throw DecodingError.typeMismatch(CategoryIdentifier.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Mismatched Types"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let idString):
            try container.encode(idString)
        case .category(let categoryObject):
            try container.encode(categoryObject)
        }
    }
}
// MARK: - Product
struct Product: Codable {
    let productId, title, description: String
    let sellerId: SellerIdentifier?
    let price: Double
    let categoryId: CategoryIdentifier
    let customizationOptions: [CustomizationOption]
    let sold: Int
    let quantity : Int
    let images: [String]
    let status: String
    let isDeleted: Bool
    let condition: String
    let hasVariations: Bool
    let variations: [Variant]? // Optional, as there may not be variations
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
    
    var category: Category? {
          switch categoryId {
          case .string(_):
              return nil
          case .category(let categoryObject):
              return categoryObject
          }
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
    var images: [String]?
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
