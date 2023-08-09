//
//  CartHeader.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 06/08/2023.
//

import Foundation


import UIKit



class CartHeader : UITableViewHeaderFooterView {
    
    
    var shopName: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header"
        label.font =  UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(shopName)
        shopName.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

