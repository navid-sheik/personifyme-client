//
//  BuyerOrderHeader.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
import UIKit



class BuyerOrderHeader : UITableViewHeaderFooterView {
    
    
    var status: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipped"
        label.font =  UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    var date : UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Apr 27,2023"
        label.font =  UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = .white
        
        return label
    }()
    
    
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = DesignConstants.primaryColor
            
        let stackLabel = StackManager.createStackView(with: [status,date], axis: .horizontal, spacing: 5, distribution: .fillEqually, alignment: .fill)
    
    
        self.addSubview(stackLabel)
        stackLabel.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

