//
//  LoginViewModel.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


//final class LoginViewModel {
//    
//    var errorMessage : ObservableObject<String?> = ObservableObject("")
//    
//    
//    func login (email : String, password : String) {
//      
//        let data  = [   "email" : email,
//                        "password" :  password
//        ]
//        
//        let jsonData  =  try? JSONSerialization.data(withJSONObject: data)
//        let request  =  Request(endpoint: .base, pathComponents: ["login"])
//            .add(headerField: "Content-Type", value: "application/json")
//            .set(body: jsonData)
//            .set(method: .POST)
//            .build()
//        
//        
//        Service.shared.execute(request, expecting: AuthResponse.self) { [weak self] result in
//            guard let strongSelf = self else {
//                    return
//            }
//            
//            switch result{
//                case .success(let daata):
//                    
//                
//            case .failure(let failure):
//                     print(failure)
//            }
//            
//            
//        }
//        
//    
//        
//    }
//    
//}
