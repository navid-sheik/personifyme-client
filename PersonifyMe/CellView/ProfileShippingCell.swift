//
//  ProfileShippingCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation


import UIKit

class ProfileShippingCell: CustomCell {
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name (Upcoming)"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = DesignConstants.primaryColor
        return label
    }()
    
    let addressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Navid Sheikh \n86 Ferenz Road,E61LL\n London United Kingdom,\n+447405341412"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    let tickButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.tintColor = UIColor.systemGreen
        return button
    }()
    
    let editButton : CustomButton = {
        let button = CustomButton(title: "Edit", hasBackground: false, fontType: .small)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deleteButton : CustomButton = {
        let button = CustomButton(title: "Delete", hasBackground: false, fontType: .small)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    

    
  
    
    override func setUpCell() {
        super.setUpCell()
        self.contentView.backgroundColor =  DesignConstants.secondaryColor
        
        let stackText  = StackManager.createStackView(with: [nameLabel, addressLabel], axis: .vertical, spacing: 8, distribution: .fillProportionally, alignment: .leading)
        
        
        let buttonStack  =  StackManager.createStackView(with: [editButton,deleteButton], axis: .horizontal, spacing: 5, distribution: .fillEqually, alignment: .fill)
        
        let stackView = StackManager.createStackView(with: [stackText,buttonStack], axis: .vertical, spacing: 5, distribution: .fill, alignment: .fill)
        
        
        self.addSubview(stackView)
        stackView.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: -10, width: nil, height: nil)
        
        
        
        
        
   
    }
}
