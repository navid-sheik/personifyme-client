//
//  SellerMenuCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//



import Foundation
import UIKit


class SellerMenuCell: CustomCell {
    
    let label : UILabel   =  {
        let label  = UILabel ()
        label.text = "Home"
        label.font  = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment =  .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .black
        return label
        
    }()
    
    let iconMenu : UIImageView =  {
        let imageView  = UIImageView()
        imageView.contentMode =  .scaleAspectFit
        imageView.image =  UIImage(systemName: "house")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containingVieww : UIView =  {
        let view  =  UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth =  1
        view.layer.cornerRadius = 2
      
        return view
    }()
    
    
    
  
    
    override func setUpCell() {
        super.setUpCell()
        
        addSubview(containingVieww)
        
        
        containingVieww.addSubview(iconMenu)
        containingVieww.addSubview(label)
        
        
        
        containingVieww.anchor( top: self.topAnchor, left: self.leadingAnchor , right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        
        iconMenu.anchor( top: nil, left: containingVieww.leadingAnchor , right: nil, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: 30, height: 30)
        iconMenu.centerYAnchor.constraint(equalTo: containingVieww.centerYAnchor).isActive = true
        
        label.anchor( top: nil, left: iconMenu.trailingAnchor , right: containingVieww.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: nil, height: 30)
        label.centerYAnchor.constraint(equalTo: containingVieww.centerYAnchor).isActive = true
   
    }
}
