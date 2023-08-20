//
//  TokenResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 30/07/2023.
//

import Foundation
struct TokenResponse : Codable{
    let refreshToken : String
    let token : String
    let user_id : String?
    let seller_id  : String?
    
}
