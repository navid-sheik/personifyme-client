//
//  ProfileCollectionViewHeader.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation


import UIKit



class ProfileCollectionViewHeader : UICollectionReusableView {
    
    
    //MARK: - PROPERTIES
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "Shipping Addresses"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor( top: nil, left:  self.leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        
        
        addSubview(addButton)
        addButton.anchor( top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: 30, height: 30)
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
        
     
        
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

