//
//  OrderInfoProduct.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation

import UIKit



class OrderInfoProductView : UIView{
    
    let productImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        
        return imageView
    }()
    
    
    
    let productTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A Unique Embodiment of Your Personal Style,Crafted with Precision, Simple Kind Something"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 1
        return label
    }()
    
    let variantLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Black,United States"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.gray
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$8.75"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.gray
        return label
    }()
    let quantityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "x1"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.gray
        label.textAlignment = .right
        return label
    }()

    
    let dummyView : UIView = {
        let custom_view  =  UIView()
        custom_view.translatesAutoresizingMaskIntoConstraints = false
        return custom_view
    }()
    
  
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
 
    
    func setupUI(){
        
       
        productImageView.backgroundColor =  .brown
        addSubview(productImageView)
        productImageView.anchor( top: self.topAnchor, left: self.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: 70, height:  70 )
        addSubview(productTitleLabel)
        
        productTitleLabel.anchor(top: self.topAnchor, left: productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        addSubview(variantLabel)
        variantLabel.anchor(top: productTitleLabel.bottomAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        
        let priceLabelQuantiyStack  = StackManager.createStackView(with: [priceLabel, quantityLabel], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .fill)
        
        addSubview(priceLabelQuantiyStack)
        priceLabelQuantiyStack.anchor(top: variantLabel.bottomAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        
        

//
//
//        addSubview(totalStack)
//
//        totalStack.anchor(top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
//
//        totalStack.centerYAnchor.constraint(equalTo: trackOrder.centerYAnchor).isActive = true
        
        
        
        
        
        
        
        
//
//        addSubview(dummyView)
//        dummyView.anchor(top: priceLabelQuantiyStack.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
