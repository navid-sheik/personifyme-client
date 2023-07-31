//
//  ErrorManager.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation
import UIKit

class ErrorManager{
    
    public static func handleServiceError(_ error : Error, on self : UIViewController?){
        if let customError = error as? ServiceError {
            switch customError {
            case .FailedToCreateRequest:
                print("Failed to create request")
                
                
                
                
            case .UnAuthorized:
                guard let self = self else { return }
                AuthManager.clearUserDefaults()
                
                print("Successful clear out the clear out data")
                AlertManager.showLogoutError(on: self, with: "Log In Again")
            case .CustomError(statusCode:  _, message: let message, errorType: _):
                guard let self = self else { return }
                AlertManager.showLogoutError(on: self, with: message)
            case .FailedToPostData:
                print("Failed to post data")
            case .FailedToGetData:
                print("Failed to get data")
            case .InvalidResponse:
                print("Invalid response")
            case .NetworkUNavailble:
                print("Network unavailable")
            case .FailedToDecodeResponse:
                print("Failed to decode response")
            case .NoResponseCode:
                print("No response code")
            }
        }else {
            print("Default error occurred: \(error)")
        }
    }
}
