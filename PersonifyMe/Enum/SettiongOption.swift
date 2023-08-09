//
//  SettiongOption.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 09/08/2023.
//

import Foundation
import UIKit



enum SettingOption:  CustomStringConvertible {
    
    
    case fullName(String)
    case email(String)
    case currency(String)
    case country(String)
    case primaryAddress(String)
    case primaryPayment(String)
    case password(String)
    case pushNotification
    case appearance
    case aboutThisApp
    case privacyPolicy
    case termsOfService
    case contactUs
    
    var customValue: String? {
        switch self {
        case .fullName(let value), .email(let value), .currency(let value), .country(let value),
                .primaryAddress(let value), .primaryPayment(let value), .password(let value):
            
            return value
            
            
        default:
            return nil
            
        }
    }
    
    var description: String {
        switch self {
        case .fullName:
            return "Full Name"
        case .email:
            return "Email"
        case .currency:
            return "Currency"
        case .country:
            return "Country"
        case .primaryAddress:
            return "Primary Address"
        case .primaryPayment:
            return "Primary Payment"
        case .password:
            return "Password"
        case .pushNotification:
            return "Push Notification"
        case .appearance:
            return "Appearance"
        case .aboutThisApp:
            return "About This App"
        case .privacyPolicy:
            return "Privacy Policy"
        case .termsOfService:
            return "Terms of Service"
        case .contactUs:
            return "Contact Us"
        }
    }
    
    var isSwitchable: Bool{
        switch self {
        case .pushNotification:
            return true
        default:
            return false
        }
    }
    
    var isSelectable: Bool{
        switch self {
        case .fullName, .email, .currency, .country, .primaryAddress, .primaryPayment, .password:
            return true
        default:
            return false
        }
    }
    
    
    
    
}









enum SettingOption2: Int, CustomStringConvertible, CaseIterable {
    case editProfile
    case changePassword
    case darkMode
    case notifications
    case privacyPolicy
    case termsOfService
    
    
    
    
    enum ButtonType {
        case normal(title: String)
        case toggle(isOn: Bool)
        case barButton(systemName: String)
    }
    
    var description: String {
        switch self {
        case .editProfile: return "Edit Profile"
        case .changePassword: return "Change Password"
        case .darkMode: return "Dark Mode"
        case .notifications: return "Notifications"
        case .privacyPolicy: return "Privacy Policy"
        case .termsOfService: return "Terms of Service"
        }
    }
    
    var dynamicValue : String? {
        switch self {
        case .editProfile: return "Edit Profile"
        case .changePassword: return "Change Password"
        case .darkMode: return "Dark Mode"
        case .notifications: return "Notifications"
        case .privacyPolicy: return "Privacy Policy"
        case .termsOfService: return "Terms of Service"
        }
        
    }
    
    
    
    var buttonType: ButtonType? {
        switch self {
        case .darkMode: return .toggle(isOn: true) // This is a placeholder. Ideally, this should get the actual value from user settings.
        case .notifications: return .toggle(isOn: false) // Placeholder as well
        case .privacyPolicy: return .barButton(systemName: "doc.text")
        case .termsOfService: return .barButton(systemName: "doc.text.magnifyingglass")
        default: return .normal(title: "Edit")
        }
    }
}
