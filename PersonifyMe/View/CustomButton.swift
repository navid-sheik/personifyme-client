//
//  CustomButton.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation
import UIKit


class CustomButton : UIButton {
    
        enum FontType {
            case big
            case medium
            case small
        
        }
        
        
    
    
        
    init(title : String, hasBackground : Bool  =  false,   fontType : FontType) {
        
        
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor =  hasBackground ? .systemBlue : .clear
        self.layer.cornerRadius =  12
        
        let titleColor : UIColor = hasBackground ? .white : .systemBlue
        
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontType {
            
            case .big:
                self.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
            case .medium:
                self.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
                
            case .small:
                self.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
                
            
        }
        
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    
}
