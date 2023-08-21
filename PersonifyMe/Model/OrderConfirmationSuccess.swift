//
//  SuccessResponse.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 28/07/2023.
//

import Foundation

struct OrderConfirmationSuccess : Codable{
    let order : Order
    let orderItems : [OrderItem]

}

