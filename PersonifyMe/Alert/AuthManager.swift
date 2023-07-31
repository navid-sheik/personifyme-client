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
    }
    
    public static func setUserDefaultsTokens (token : String , refresh_token : String ){
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
//        UserDefaults.standard.set(verified, forKey: "verified")
        
        
    }
    public static func setUserDefaults (token : String , refresh_token : String , verified : Bool){
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(refresh_token, forKey: "refresh_token")
        UserDefaults.standard.set(verified, forKey: "verified")
        
        
    }
    
   
    
    
    
}
