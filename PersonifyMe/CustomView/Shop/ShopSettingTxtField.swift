//
//  ShopSettingTxtField.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 18/08/2023.
//

import Foundation


import UIKit

class ShopSettingTxtField : UIView {
   
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text  = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var  textField : UITextField = {
        let textField = UITextField()
//        let spacer  =  UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.leftView =  spacer
        textField.leftViewMode =  .always
        textField.textColor =  .lightGray
        textField.keyboardAppearance =  .dark
        textField.backgroundColor =  UIColor(white: 1, alpha: 0.1)
        textField.placeholder = "Option value"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.gray
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = true
  
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    
    let editButton: CustomButton = {
        let button  = CustomButton(title: "Edit", hasBackground: true,  fontType: .small)
        return button
    }()
    
    
    
    
    var title : String
    var value : String
    

    
    init(title: String, value: String) {
            self.title = title
            self.value = value
            super.init(frame: .zero)
//            self.backgroundColor =  .blue
           
                self.translatesAutoresizingMaskIntoConstraints = false
                self.isUserInteractionEnabled = true
                editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
                textField.delegate = self
                textField.isEnabled = false
        
        textField.text = value
                 
                setUpView()
           
            // Setup your view here (e.g., add subviews and set constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        
        self.addSubview(editButton)
        self.addSubview(titleLabel)
        self.addSubview(textField)
        
        // Center editButton both vertically and horizontally
        titleLabel.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        editButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        editButton.anchor( top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 3, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        
        
        
        
        textField.anchor( top: self.titleLabel.bottomAnchor, left: self.leadingAnchor, right: editButton.leadingAnchor, bottom: nil, paddingTop: 3, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: 30)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      
        
    
        
    }
    
    var isEnabled: Bool = false {
           didSet {
               if isEnabled {
                   enableTextField()
               } else {
                   disableTextField()
               }
           }
       }
    
    @objc func didTapEdit(){
        isEnabled.toggle()
       
    }
    
    func enableTextField() {
            textField.isEnabled = true
            textField.becomeFirstResponder()
            editButton.setTitle("Done", for: .normal)
        }
        
    // Function to disable the text field
    func disableTextField() {
        
        if let text =  textField.text  ,  text != "" {
            self.value =  text
        }else {
            textField.text = self.value
        
        }
        textField.isEnabled = false
        textField.resignFirstResponder()
        editButton.setTitle("Edit", for: .normal)
    }
    
    
    
    func setText(  value : String ){
        if value != "" {
            textField.text = value
            self.value = value
        
        }
    }
    
    func getText () -> String{
        return self.value
    }
    
    
    
 
    
    
    
    
    
    
    
}

extension ShopSettingTxtField : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let text =  textField.text  ,  text != "" {
//            self.value =  text
//        
//        }else {
//            textField.text = self.value
//        
//        }
//        
//    }
}

