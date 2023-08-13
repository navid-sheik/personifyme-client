//
//  OrderBuyerCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
import UIKit



class OrderBuyerSell : UITableViewCell{
    
    let productImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        
        return imageView
    }()
    
    
    let shopLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Shop"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.numberOfLines = 1
        return label
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
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$8.75"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    let quantityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "x1"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.textAlignment = .right
        return label
    }()
    
    let totalPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let totalPriceValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$59.90"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let trackOrder : CustomButton = {
        let button  = CustomButton(title: "Track Order", hasBackground: true,  fontType: .small)
        
        return button
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
        variantLabel.anchor(top: productTitleLabel.bottomAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        let priceLabelQuantiyStack  = StackManager.createStackView(with: [priceLabel, quantityLabel], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .center)
        
        addSubview(priceLabelQuantiyStack)
        priceLabelQuantiyStack.anchor(top: variantLabel.bottomAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
        let totalStack  = StackManager.createStackView(with: [totalPlaceholder, totalPriceValue], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .fill)
        


        addSubview(trackOrder)

        let widthButton = self.frame.width / 3
        trackOrder.anchor(top:  productImageView.bottomAnchor, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: widthButton, height: 30)


//        addSubview(totalStack)
//
//        totalStack.anchor(top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
//
//        totalStack.centerYAnchor.constraint(equalTo: trackOrder.centerYAnchor).isActive = true
//
//

        
        
        
        
        
        
        addSubview(dummyView)
       
        dummyView.anchor(top: trackOrder.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0 , width: nil, height: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
