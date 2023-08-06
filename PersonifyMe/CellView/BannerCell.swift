//
//  BannerCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 03/08/2023.
//

import Foundation
import Foundation
import UIKit

enum TypeBanner {
    case mainTop
    case category
}

class BannerCell : CustomCell{
    
    var typeBanner  :  TypeBanner? {
        didSet{
            switch typeBanner{
            
            case .mainTop:
                self.mainImage.contentMode = .scaleAspectFill
            case .category:
                self.mainImage.contentMode = .scaleAspectFit
                self.mainImage.backgroundColor =  .systemGray6
            case .none:
                return
            }
        }
    }
    
    let mainImage : CustomImageView =  {
        let imageView =  CustomImageView()
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        return imageView
    }()
    
    
    override func setUpCell() {
        addSubview(mainImage)
        mainImage.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
}
