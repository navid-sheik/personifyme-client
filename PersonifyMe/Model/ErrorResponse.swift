//
//  ErrorResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation



struct MessageError : Codable{
    let message : String
}
struct ReponseError : Codable{
    let  errors : [MessageError]

    
    
}
