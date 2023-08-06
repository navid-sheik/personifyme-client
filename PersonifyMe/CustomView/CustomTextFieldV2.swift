//
//  CustomTextFieldV2.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 03/08/2023.
//

import Foundation
import UIKit
class CustomTextFieldV2 : UITextField{
    
    init(placeholder : String) {
        super.init(frame: .zero)
        let spacer  =  UIView()
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: 12).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        leftView =  spacer
        leftViewMode =  .always
        textColor =  .white
        keyboardAppearance =  .dark
        backgroundColor =  UIColor(white: 1, alpha: 0.1)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        attributedPlaceholder =  NSAttributedString(string: placeholder, attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7) ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
