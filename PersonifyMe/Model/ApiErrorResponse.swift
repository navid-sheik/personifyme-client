//
//  ApiErrorResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 30/07/2023.
//

import Foundation

struct ApiErrorResponse: Codable{
    var status : String
    var message : String
    var statusCode : Int
    var errorType : String

}
