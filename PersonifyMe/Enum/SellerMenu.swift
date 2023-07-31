//
//  SellerCustomButton.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//



import Foundation
import UIKit


enum SellerMenu : Int, CustomStringConvertible, CaseIterable {
  
    
    case Orders
    case Listings
    case Messages
    case Reviews
    case ListItem
    case Shop
    case MyInfo
    case Support
    
    var description: String{
        switch self {
            
        case .Orders:
            return "Orders"
        case .Listings:
            return "Listings"
        case .Messages:
            return "Messages"
        case .Reviews:
            return "Reviews"
        case .ListItem:
            return "List Item"
        case .Shop:
            return "Shop"
        case .MyInfo:
            return "My Info"
        case .Support:
            return "Support"
        }
    }
    
    
    
    var imageSetting : String {
        switch self {
            
        case .Orders:
            return "shippingbox.fill"
        case .Listings:
            return "pencil"
        case .Messages:
            return "message.fill"
        
        case .Reviews:
            return  "star.fill"
        case .ListItem:
            return "plus.app.fill"
        case .Shop:
            return "bag.fill"
        case .MyInfo:
            return "gearshape.fill"
        case .Support:
            return "questionmark.circle.fill"
        }
    }
    
    
}




