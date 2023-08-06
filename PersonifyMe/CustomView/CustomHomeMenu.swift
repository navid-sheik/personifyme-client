//
//  CustomHomeMenu.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 03/08/2023.
//

import Foundation

import UIKit


class CustomHomeMenu  : UIView {
    
    let buttonBarItem  : UIButton =  {
        let button =  UIButton ()
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        return button
    }()
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonBarItem)
        buttonBarItem.anchor(top: nil, left: leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 50, height: 50)
        buttonBarItem.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


