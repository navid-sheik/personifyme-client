//
//  LabeledTextField.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 01/08/2023.
//

import Foundation
import UIKit

class LabeledTextField: UIView, UITextFieldDelegate {
    let label: UILabel
    let textField: BorderedTextField
   
    
    init(labelText: String, placeholder: String) {
        label = UILabel()
        textField = BorderedTextField()
    
        
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = labelText
        label.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
     
        
        addSubview(label)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.heightAnchor.constraint(equalToConstant: 20),
            
            
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 1), // 4 points space
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Your code here
        return true
    }
    


    // Add other delegate methods as needed...
}
