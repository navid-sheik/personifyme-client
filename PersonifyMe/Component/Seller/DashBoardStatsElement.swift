//
//  DashBoardStatElement.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//

import Foundation
import UIKit


class DashBoardStatsElement : UIView{
    
    
    //MARK COMPONENTS
    
    let placeholder : String
    let value : String
    
    var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Total Sales"
        label.textAlignment =  .left
        return label
    }()
    
    var valueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "$100"
        label.textAlignment =  .center
        return label
    }()
    
    
    init(placeholder: String, value: String) {
        self.placeholder = placeholder
        self.value = value
        super.init(frame: .zero)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
 
    
    func setUpView (){
        addSubview(titleLabel)
        addSubview(valueLabel)
        titleLabel.text   = placeholder
        valueLabel.text =  value
        
        titleLabel.anchor( top: self.topAnchor, left: self.leadingAnchor , right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 20)
        
        valueLabel.anchor( top: titleLabel.bottomAnchor, left: self.leadingAnchor , right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 60)
        

        
        
    }
    
    
    
}
