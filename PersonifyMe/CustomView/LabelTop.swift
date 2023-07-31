//
//  LabelTop.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//


import Foundation

import UIKit
class LabelTop : UILabel {
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: super.intrinsicContentSize.width, height: super.intrinsicContentSize.height - 100)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
