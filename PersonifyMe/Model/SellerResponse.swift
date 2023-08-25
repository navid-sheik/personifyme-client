//
//  SellerResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 30/07/2023.
//

import Foundation

struct SellerResponse : Codable{
    var success : Bool
    var result : SellerResult
    
}

struct SellerResult : Codable {
    var seller_id: String
    var hasStartedOnboarding: Bool
    var hasCompletedOnboarding: Bool
  
    
    enum CodingKeys: String, CodingKey {
        case seller_id = "id"
        case hasStartedOnboarding
        case hasCompletedOnboarding
    }
    
  
    
}
