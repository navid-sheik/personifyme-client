//
//  OrderStatus.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation


import UIKit


class  OrderStatusCell : UITableViewCell{
    
    
    //MARK: COMPONENTS
    
    let status : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status: Shipped"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    let message  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Click the table view cell and in the attributes inspector under Table View Cell, change the drop down next "
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
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
        self.addSubview(status)
        status.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        self.addSubview(message)
        message.anchor(top: status.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: -10, width: nil, height: nil)
    
    }
}
