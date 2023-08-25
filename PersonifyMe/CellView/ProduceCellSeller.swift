//
//  ProduceCellSeller.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 21/08/2023.
//

import Foundation
//
//  ProductCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 03/08/2023.
//

import UIKit

enum StatusSellerListingEnum {
    case Approved
    case Rejected
    case Pending
}

protocol ProduceCellSellerDelegate : class{
    func statusProduct( isApproved : StatusSellerListingEnum,  with message : String)
}

class ProduceCellSeller :  CustomCell{
    weak var delegate : ProduceCellSellerDelegate?
    
    var product : Product?{
        didSet{
            guard let product =  product  else {return}
            if let urlString  = product.images.first{
                self.mainImage.loadImageUrlString(urlString: urlString)
            }
            
            if product.isApproved{
                self.button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                self.button.tintColor =  UIColor.green
            
            }else {
                if let _ =  product.moderationMessage{
                    self.button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
                    self.button.tintColor =  UIColor.red
                
                }else {
                    self.button.setImage(UIImage(systemName: "clock.badge.checkmark"), for: .normal)
                    self.button.tintColor =  UIColor.gray
                }
            }
            
            
        }
    }
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    let button : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = DesignConstants.primaryColor
        button.tintColor =  UIColor.green
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    
    override func setUpCell() {
        //stylingCell()
        
        self.button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        contentView.addSubview(mainImage)
        mainImage.anchor(top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        contentView.addSubview(button)
        button.anchor(top: nil, left: nil, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: -5, paddingBottom: -5, width: 25, height: 25)
        
        
    
        
        
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
    
    @objc func handleButton(){
        print("Tapping")
        guard  let isApproved = product?.isApproved else {return}
        if isApproved{
        
            delegate?.statusProduct(isApproved: .Approved, with: "Your product has been approved")
        
        }else {
            if let message =  product?.moderationMessage{
                delegate?.statusProduct(isApproved: .Rejected, with:  message)
            }else {
                delegate?.statusProduct(isApproved: .Pending, with:  "Your product is pending approval")
            }
        }
    }
}
