//
//  SingleOrderProduct.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//


import Foundation
import UIKit



class SingleOrderProduct : UITableViewCell{
    
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
    let personalizationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.gray
        return label
    }()

    
    let dummyView : UIView = {
        let custom_view  =  UIView()
        custom_view.translatesAutoresizingMaskIntoConstraints = false
        return custom_view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.contentView.backgroundColor =  UIColor.init(red: 0.949, green: 0.949, blue: 0.97, alpha: 1.0)
        setupUI()
        
        
    }
    
    func setupUI(){
        
        let width = self.frame.width / 4
        addSubview(productImageView)
        productImageView.anchor( top: self.topAnchor, left: self.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: width, height: width)
        addSubview(productTitleLabel)
        
        productTitleLabel.anchor(top: self.topAnchor, left: productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        addSubview(variantLabel)
        variantLabel.anchor(top: productTitleLabel.bottomAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 8, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        let priceLabelQuantiyStack  = StackManager.createStackView(with: [priceLabel, quantityLabel], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .center)
        
        addSubview(priceLabelQuantiyStack)
        priceLabelQuantiyStack.anchor(top: variantLabel.bottomAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 8, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
        
//        addSubview(personalizationLabel)
//        personalizationLabel.anchor(top: priceLabelQuantiyStack.bottomAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: -10, paddingBottom: nil, width: nil, height: nil)
//
        
        
        

//
//
//        addSubview(totalStack)
//
//        totalStack.anchor(top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
//
//        totalStack.centerYAnchor.constraint(equalTo: trackOrder.centerYAnchor).isActive = true
        
        
        
        
        
        
        
        

        addSubview(dummyView)
        dummyView.anchor(top: productImageView.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
