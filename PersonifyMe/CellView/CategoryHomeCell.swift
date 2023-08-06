//
//  CategoryHomeCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 03/08/2023.
//

import Foundation

import UIKit

class CategoryHomeCell :  CustomCell{
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    var label :  UILabel = {
        let label = UILabel ()
        label.text = "Category"
        label.sizeToFit()
        label.font =  UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func setUpCell() {
        //stylingCell()
        contentView.addSubview(mainImage)
        contentView.addSubview(label)
        mainImage.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        label.anchor(top: mainImage.bottomAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
    }
    
   
}
