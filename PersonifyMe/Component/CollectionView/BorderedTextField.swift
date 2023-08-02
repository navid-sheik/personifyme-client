//
//  BorderedTextField.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 01/08/2023.
//

import Foundation
import UIKit
class BorderedTextField: UITextField {
    
    var bottomLine: CALayer?
    
    // Initialize the BorderedTextField
    init() {
        super.init(frame: .zero)
        setupBottomBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBottomBorder()
    }
    
    // Method to setup the bottom border
    func setupBottomBorder() {
        self.borderStyle = .none
        self.backgroundColor = .none
        
        
        self.returnKeyType =  .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
//        self.leftViewMode = .always
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
//        self.translatesAutoresizingMaskIntoConstraints = false

        
        let bottomLine = CALayer()
        bottomLine.backgroundColor = UIColor.gray.cgColor // Change this to the color you want
        self.layer.addSublayer(bottomLine)
        self.bottomLine = bottomLine
    }
    
    // Override layoutSubviews to correctly position the bottom border
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine?.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
    }
}
