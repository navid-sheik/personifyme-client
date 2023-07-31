//
//  AlertManager.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation
import UIKit



class AlertManager {
    
    private static func showBasicAlert(on vc : UIViewController ,  title : String,   message:String?){
      
       
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style:.default, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK : - Login Alerts
extension AlertManager{
    public static func showLogoutAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Success logout", message: "You've been successfully logout")
    }
    
    public static func showInvalidEmailAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email address")
    }
    
    public static func showInvalidPasswordAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Invalid Password", message: "Please enter a valid password")
    }
    
    public static func showInvalidUsernameAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Invalid Username", message: "Please enter a valid username")
    }
    public static func showInvalidFullNameAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Invalid Full Name", message: "Please enter a valid full name")
    }
    
    public static func showPasswordNotMatch(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Password Not Match", message: "Please enter same password")
    }
    
}


//MARK : - Register Alerts
extension AlertManager{
    
    
    
    public static func showRegistrationErrorAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Registration Error", message: "An error occured during registration. Please try again later")
    }

    
    
    public static func showRegistrationErrorAlert(on vc : UIViewController, with error: Error){
        showBasicAlert(on: vc, title: "Registration Error",  message: "\(error.localizedDescription)")
    }
    
    
}

//MARK : - Login Alerts
extension AlertManager{
    public static func showLoginErrorAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Login Error", message: "An error occured during login. Please try again later")
    }

    
    
    public static func showLoginErrorAlert(on vc : UIViewController, with error: Error){
        showBasicAlert(on: vc, title: "Login Error",  message: "\(error.localizedDescription)")
    }
    
    
}

//MARK : - Reset Password Alerts
extension AlertManager{
    public static func showResetPasswordErrorAlert(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Reset Password Error", message: "An error occured during password reset. Please try again later")
    }

    
    
    public static func showResetPasswordErrorAlert(on vc : UIViewController, with error: Error){
        showBasicAlert(on: vc, title: "Reset Password Error",  message: "\(error.localizedDescription)")
    }
    
    
    public static func showSendingPasswordReset(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Password Reset Sent", message: "An error occured during password reset. Please try again later")
    }
    public static func showErrorSendingPasswordReset(on vc : UIViewController, with error: Error){
        showBasicAlert(on: vc, title: "Password Reset Error",  message: "\(error.localizedDescription)")
    }
    
    
}


//MARK : - Logout Alerts

extension AlertManager{
    public static func showLogoutError(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Logout", message: "An error occured during logouy reset. Please try again later")
    }
    public static func showLogoutError(on vc : UIViewController, with error: String){
        showBasicAlert(on: vc, title: "Reset Password Error",  message:  error)
    }
    
}

//MARK : - Fetching User Errors

extension AlertManager{
    
    public static func showUnknownFetchingUserError(on vc : UIViewController){
        showBasicAlert(on: vc, title: "Password Reset Sent", message: "An error occured during password reset. Please try again later")
    }
    
    public static func showFetchingUserError(on vc : UIViewController, with error: Error){
        showBasicAlert(on: vc, title: "Reset Password Error",  message: "\(error.localizedDescription)")
    }
    
    
}
