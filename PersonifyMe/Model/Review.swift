//
//  Review.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 02/08/2023.
//

import Foundation




struct Review: Codable {
    let reviewId: String
    let productId: Product
    let rating: Int
    let text: String?
    let user_info : UserInfoReview
    let createdAt, updatedAt: String?
    

    enum CodingKeys: String, CodingKey {
        case reviewId = "_id"
        case user_info =  "user_id"
        case productId ,  rating, text
        case createdAt, updatedAt
    }
}


struct UserInfoReview: Codable{
    let userId : String
    let name : String
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "_id"
        case name , image
    }

}
 
