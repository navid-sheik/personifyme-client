//
//  CustomProductVariant.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 13/08/2023.
//

import Foundation

import Foundation
import UIKit



import DropDown

class  VariantProductViewField:  UIView {
    
  
    //MARK: PRIOPRITIES
    
    var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Option name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    

    
    
    var  textField : UITextField = {
        let textField = UITextField()
        let spacer  =  UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        

        textField.leftView =  spacer
        textField.leftViewMode =  .always
        textField.textColor =  .lightGray
        textField.keyboardAppearance =  .dark
        textField.backgroundColor =  UIColor(white: 1, alpha: 0.1)
//        textField.attributedPlaceholder =  NSAttributedString(string: "Size", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7) ])

        textField.placeholder = "Option value"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.gray
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        
        return textField
    }()
    
    let dropDown = DropDown()
    
    
 
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setUpView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setUpView(){
        
        
        let stackView  = StackManager.createStackView(with: [label, textField], axis: .vertical, spacing: 0, distribution: .fillProportionally, alignment: .fill)
        
        textField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
       
        
//        
//        addSubview(label)
//        label.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//        
//        
//        addSubview(textField)
//        
//        textField.anchor(top: self.label.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//        
      
        
        
        
        
       
//            label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
//            let stackVertical  = StackManager.createStackView(with: [label, textField], axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .fill)
//
//            addSubview(stackVertical)
//
//
////            label.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
////
////            addSubview(textField)
////
//            stackVertical.anchor(top:  self.label.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
////
////            deleteButton.isHidden = compulsoryBool
////            let stackView  = StackManager.createStackView(with: [textField, deleteButton], axis: .horizontal, spacing: 5, distribution: .fill, alignment: .fill)
////            stackView.isUserInteractionEnabled = true
////
////            addSubview(stackView)
////            stackView.anchor(top:  self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
//
    
     
        

        
       
        
    }
    
   
    
}


