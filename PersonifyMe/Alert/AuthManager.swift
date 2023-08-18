//
//  AuthManager.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation


class AuthManager {
    
   
    
    
    public static func clearUserDefaults (){
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
        UserDefaults.standard.removeObject(forKey: "verified")
        UserDefaults.standard.removeObject(forKey: "user_id")
        UserDefaults.standard.removeObject(forKey: "seller_id")
        
    }
    
    public static func setUserDefaultsTokens (token : String , refresh_token : String, user_id: String , seller_id : String? ){
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
        UserDefaults.standard.set(user_id, forKey: "user_id")
        if let seller_id = seller_id {
            UserDefaults.standard.set(seller_id, forKey: "seller_id")
        }
        
        
//        UserDefaults.standard.set(verified, forKey: "verified")
        
        
    }
    public static func setUserDefaults (token : String , refresh_token : String , verified : Bool, user_id: String, seller_id : String? ){
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
        UserDefaults.standard.set(verified, forKey: "verified")
        UserDefaults.standard.set(user_id, forKey: "user_id")
        if let seller_id = seller_id {
            UserDefaults.standard.set(seller_id, forKey: "seller_id")
        }
        
        
        
    }
    
   
    
    
    
}
