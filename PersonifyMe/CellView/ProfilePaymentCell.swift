//
//  ProfilePaymentCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation
import UIKit

class ProfilePaymentCell: CustomCell {
    
    
    let cardNumber : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "***3875"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let paymentExpire : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Expires on 1/27"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    let typeCard : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "creditcard.fill"), for: .normal)
        button.tintColor = UIColor.systemGreen
        return button
    }()
    
    
    let editButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        button.tintColor = UIColor.systemGreen
        return button
    }()
    
    
    
    
    

    

    
  
    
    override func setUpCell() {
        super.setUpCell()
        self.contentView.backgroundColor =  UIColor.init(red: 0.949, green: 0.949, blue: 0.97, alpha: 1.0)
        
        
        editButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let topLine  = StackManager.createStackView(with: [cardNumber, editButton], axis: .horizontal, spacing: 8, distribution: .fillProportionally, alignment: .center)

        
        
        typeCard.widthAnchor.constraint(equalToConstant: 30).isActive = true
        typeCard.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let buttonStack  =  StackManager.createStackView(with: [paymentExpire,typeCard], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .center)
        
        let stackView = StackManager.createStackView(with: [topLine,buttonStack], axis: .vertical, spacing: 5, distribution: .equalSpacing, alignment: .fill)
        
        
        self.addSubview(stackView)
        stackView.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: -5, paddingBottom: -5, width: nil, height: nil)
        
        
        
        
        
   
    }
}
