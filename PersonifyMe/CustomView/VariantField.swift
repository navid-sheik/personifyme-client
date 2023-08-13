//
//  VariantField .swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 04/08/2023.
//

import Foundation
import UIKit



protocol VariantFieldDelegate: AnyObject {
    func variantFieldDidRequestDeletion(_ field: VariantField)
}

class  VariantField:  UIView {
    
    weak var delegate: VariantFieldDelegate?
    
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
    
    let deleteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:  "trash" ), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let deleteButtonOption : UIButton = {
        let button = CustomButton(title: "DELETE", hasBackground: true, fontType: .small)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    
    
    
    var optionBool : Bool
    var compulsoryBool : Bool
    
    
    init(isOption : Bool = true, isCompulsory : Bool = false) {
        self.optionBool =  isOption
        self.compulsoryBool =  isCompulsory
        
        super.init(frame: .zero)
        deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        deleteButtonOption.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        setUpView()
    }
    
    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView(){
        
        
        
        
       
        
        if (optionBool) {
           
            addSubview(deleteButtonOption)
            deleteButtonOption.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    
            deleteButtonOption.isHidden = compulsoryBool
            
            let stackView  = StackManager.createStackView(with: [textField, deleteButtonOption], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .fill)
            stackView.isUserInteractionEnabled = true
            
            addSubview(stackView)
            stackView.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
            
        }else {
//            addSubview(label)
//
//
//            label.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
//
            deleteButton.isHidden = compulsoryBool
            let stackView  = StackManager.createStackView(with: [textField, deleteButton], axis: .horizontal, spacing: 5, distribution: .fill, alignment: .fill)
            stackView.isUserInteractionEnabled = true
            
            addSubview(stackView)
            stackView.anchor(top:  self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 5, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
            
            
        }
        
     
        

        
       
        
    }
    
    @objc func handleDelete() {
            print("deleting")
        
           delegate?.variantFieldDidRequestDeletion(self)
       }
    
    
    
    
    
}
