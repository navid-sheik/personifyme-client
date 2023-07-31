//
//  VerificationStatus.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation

import UIKit

class VerificationStatusView :  UIView {
    
    let label : UILabel   =  {
        let label  = UILabel ()
        label.text = "Verified"
        label.font  = UIFont.boldSystemFont(ofSize: 14)
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
        button.setImage(UIImage(systemName: "arrowtriangle.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        
        
        
        return button
        
    }()
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth =  1
        self.layer.cornerRadius = 2
        
        setUpView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func setUpView (){
        
        self.addSubview(iconMenu)
       self.addSubview(label)
        
        self.addSubview(displayInfoVerificationButton)
        iconMenu.anchor( top: nil, left: self.leadingAnchor , right: nil, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: 30, height: 30)
        iconMenu.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        displayInfoVerificationButton.anchor( top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: -5, paddingBottom: 0, width: 20, height: 20)
        displayInfoVerificationButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        label.anchor( top: nil, left: iconMenu.trailingAnchor , right: displayInfoVerificationButton.leadingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: nil, height: 30)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        

        
        
   
    }

}
    

