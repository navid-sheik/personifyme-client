//
//  AuthResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation


struct AuthResponse : Codable{
    let refreshToken : String
    let token : String
    let verified : Bool
    
    
}
