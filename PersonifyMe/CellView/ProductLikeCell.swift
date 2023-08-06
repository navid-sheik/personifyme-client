//
//  ProductLikeCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import Foundation
import UIKit

class ProductLikeCell :  CustomCell{
    
    let favouriteButton: UIButton = {
        let button = UIButton(type: .system)
        
        if let image = UIImage(named: "heart") {
            // Set the tint color for the image
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
            button.tintColor = .brown
        }

        // Set the background color for the button
//        button.backgroundColor = .lightGray
        
        return button
    }()
    
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
        favouriteButton.addTarget(self, action: #selector(handleLikeProduct), for: .touchUpInside)
        contentView.addSubview(mainImage)
        contentView.addSubview(favouriteButton)
        mainImage.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        favouriteButton.anchor(top: topAnchor, left: nil, right: trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 0, paddingRight: -5, paddingBottom: 0, width: 40, height: 40)
        
        
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
    
    @objc func handleLikeProduct(){
        print("Like Product")
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
    }
}
