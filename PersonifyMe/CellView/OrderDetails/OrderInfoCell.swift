//
//  OrderInfo.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
//
//  OrderStatus.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation


import UIKit


class  OrderInfoCell : UITableViewCell{
    
    
    //MARK: COMPONENTS
    
    let placeholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Order Info"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = DesignConstants.textColor
     
        return label
    }()
    
    let addressPlaceholder  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Address"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    let addressValue  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text =  "Navid Sheikh \n+447405341412 \n 86 Ferenz Road \n London, GB, E3 2NT"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    let orderIDPlaceholder  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Order ID"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    let orderIDValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "124668490690707"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    let orderDatePlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Order placed on"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    let orderDateValue  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mar 31, 2023 15:37"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    
    let paymentPlaceholder  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Payment method"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    let paymentValue  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Credit/Debit Card"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    
    let messageButton  : CustomButton =  {
        let button = CustomButton(title: "Message Seller", hasBackground:  true, fontType: .medium)
        return button
    }()
    
    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor =  DesignConstants.secondaryColor
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell (){
        
        addSubview(placeholder)
        
        placeholder.anchor(top:  self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 40)
        
        
        
        
        let addressStackView =  StackManager.createStackView(with: [addressPlaceholder,  addressValue], axis: .horizontal, spacing: 0, distribution: .fillProportionally, alignment: .leading)
        
        addSubview(addressStackView)
        
        

        addressStackView.anchor(top:  placeholder.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        let orderIDStackView =  StackManager.createStackView(with: [orderIDPlaceholder,  orderIDValue], axis: .horizontal, spacing: 0, distribution: .fillProportionally, alignment: .leading)
        
        addSubview(orderIDStackView)
        
        orderIDStackView.anchor(top:  addressStackView.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        //Order placed date
        let orderDateStackView =  StackManager.createStackView(with: [orderDatePlaceholder,  orderDateValue], axis: .horizontal, spacing: 0, distribution: .fillProportionally, alignment: .leading)
        
        addSubview(orderDateStackView)
        
        orderDateStackView.anchor(top:  orderIDStackView.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        //Payment method
        let paymentStackView =  StackManager.createStackView(with: [paymentPlaceholder,  paymentValue], axis: .horizontal, spacing: 0, distribution: .fillProportionally, alignment: .leading)
        
        addSubview(paymentStackView)
        
        paymentStackView.anchor(top:  orderDateStackView.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        addSubview(messageButton)
        
        messageButton.anchor(top:  paymentStackView.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: -10, paddingBottom: -40, width: nil, height: 40)
        
        
    
        
        
        
        
        
        
    
    }
}
