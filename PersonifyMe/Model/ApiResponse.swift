//
//  ApiResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 30/07/2023.
//

import Foundation
struct ApiResponse<T: Codable>: Codable {
    var status : String
    var message : String
    var data : T?
}


