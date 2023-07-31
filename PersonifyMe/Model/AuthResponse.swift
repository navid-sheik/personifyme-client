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


struct AuthResponse2 : Codable{
    let email : String
    let username : String
    let name : String
    let verified : Bool
    let token : String
    let refreshToken : String
}
