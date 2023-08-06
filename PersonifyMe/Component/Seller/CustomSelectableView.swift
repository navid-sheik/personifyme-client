//
//  SelectableView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 01/08/2023.
//

import Foundation
import Foundation

import UIKit

class CustomSelectableView :  UIView {
    
    var labelName : String{
        didSet{
            self.label.text =  labelName
        }
    }
    let iconImageName : String?
    
    var value : String? = nil
    
    
    let label : UILabel   =  {
        let label  = UILabel ()
        label.text = "Verified"
        label.font  = UIFont.systemFont(ofSize: 16)
        label.textAlignment =  .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .black
        return label
        
    }()
    
    let iconMenu : UIImageView =  {
        let imageView  = UIImageView()
        imageView.contentMode =  .scaleAspectFit
        imageView.image =  UIImage(systemName: "checkmark.seal.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containgView : UIView =  {
        let view  =  UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth =  1
        view.layer.cornerRadius = 2
      
        return view
    }()
    
    
    let displayInfoVerificationButton : UIButton  = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        
        
        
        return button
        
    }()
    
    
    
    

    
     init(labelName: String, imageName: String? ) {
        self.labelName = labelName
        self.iconImageName =  imageName
         self.label.text =  labelName
        super.init(frame: .zero)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth =  1
        self.layer.cornerRadius = 2
         self.isUserInteractionEnabled = true
        
        setUpView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setUpView (){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let iconImageName {
            
            self.addSubview(iconMenu)
            iconMenu.image = UIImage(systemName: iconImageName)
            iconMenu.anchor( top: nil, left: self.leadingAnchor , right: nil, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: 30, height: 30)
            iconMenu.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
   
       self.addSubview(label)
        
        self.addSubview(displayInfoVerificationButton)
      
        
        displayInfoVerificationButton.anchor( top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: 20, height: 20)
        displayInfoVerificationButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        label.anchor( top: nil, left: (iconImageName != nil) ? iconMenu.trailingAnchor : self.leadingAnchor , right: displayInfoVerificationButton.leadingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -20, paddingBottom: 0, width: nil, height: 30)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        

        
        
   
    }
    
    public func setNewValueForLabel (_ value : String){
        self.labelName =  value
        self.value = value
    }
    
    public func getValue() -> String?{
        return self.value ?? nil
    
    }

}
    
