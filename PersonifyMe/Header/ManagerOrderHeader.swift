//
//  ManagerOrderHeadr.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
import UIKit



class ManagerOrderHeader : UITableViewHeaderFooterView {
    
    
    var toBeShipped: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To be shipped in 7 days - Priority Shipping"
        label.font =  UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .white
        return label
    }()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .black
        
    
        self.addSubview(toBeShipped)
        toBeShipped.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

