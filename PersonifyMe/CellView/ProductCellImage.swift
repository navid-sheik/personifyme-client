//
//  ProductCellImage.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 04/08/2023.
//

import Foundation
import UIKit

class ProductCellImage :  CustomCell{
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    override func setUpCell() {
        //stylingCell()
        contentView.addSubview(mainImage)
        mainImage.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
    
    private func stylingCell(){
        self.contentView.backgroundColor =  .black
        self.contentView.layer.borderWidth =  1.0
        self.contentView.layer.borderColor =  UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOffset =  CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius =  2.0
        self.layer.shadowOpacity =  0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
