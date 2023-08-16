//
//  OrderPersonalization.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 16/08/2023.
//

import Foundation



import UIKit


class  OrderStatusPersonalization : UITableViewCell{
    
    
    //MARK: COMPONENTS
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Personalization"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.gray
        return label
    }()
    
    let personalization : UITextView =  {
        let label  =  UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.layer.borderWidth = 1
//        label.layer.borderColor =  UIColor.gray.cgColor
//        label.layer.cornerRadius = 4
//        label.layer.masksToBounds = true
        
        label.isEditable = false
        label.text = ""
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.isScrollEnabled = true
        return label
    }()
    
    
   
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor =  UIColor.init(red: 0.949, green: 0.949, blue: 0.97, alpha: 1.0)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell (){
        self.addSubview(label)
        label.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        self.addSubview(personalization)
        personalization.anchor(top: label.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: -10, width: nil, height: 50)
    
    }
}
