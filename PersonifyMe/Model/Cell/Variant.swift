//
//  Variant.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 12/08/2023.
//

import Foundation


struct Variant : Codable{
    var variantId : String?
    var name: String?
    var options: [String]
    
    enum CodingKeys: String, CodingKey {
        case variantId = "_id"
        case name, options
    }
    
}
