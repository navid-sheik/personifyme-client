//
//  CustomTextField.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import Foundation



import UIKit


class CustomTextField : UITextField {
    
    enum TextFieldType {
        case email
        case password
        case username
        case name
        case custom
        
    }
    
    private let fieldType : TextFieldType
    
    
    init(fieldType : TextFieldType,_ text : String? = "") {
        self.fieldType = fieldType
        super.init(frame: .zero)
        self.backgroundColor =  .secondarySystemBackground
        self.layer.cornerRadius =  10
        
        self.returnKeyType =  .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        switch fieldType {
            
        case .email:
            self.placeholder = "Email"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        
        case .username:
            self.placeholder = "Username"
            
        case .name:
            self.placeholder = "Full Name"
        
        case .custom:
            self.placeholder =  text
        
     
        }
       
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
