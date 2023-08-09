//
//  CartViewCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 06/08/2023.
//

import Foundation
import UIKit


class CartViewCell : UITableViewCell{
    
    //MARK: Propriets
    
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
        label.numberOfLines = 2
        return label
    }()
    
    let productPriceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$150.22"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.gray
        return label
    }()
    
    let productVariantAndQuantiy : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Black/Somethign"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    let personalizationTextView : UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Text: My Name is navid"
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = UIColor.gray
        textView.numberOfLines = 0
        return textView
    }()
    
    let deleteButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.square"), for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    let addQuantityButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .systemBlue
//        button.backgroundColor = .systemGray4
        return button
    }()
    
    
    let quantyLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    let removeQuantityButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .systemBlue
//        button.backgroundColor = .systemGray4
        return button
    }()
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Components
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
   
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
            
        addSubview(productImageView)
        addSubview(productTitleLabel)
//        addSubview(productPriceLabel)
//        addSubview(productVariantAndQuantiy)
//        addSubview(personalizationTextView)
        addSubview(deleteButton)
//        addSubview(addQuantityButton)
//        addSubview(quantyLabel)
//        addSubview(removeQuantityButton)
//    
  
        
        
        deleteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let topStack  = StackManager.createStackView(with: [ productTitleLabel, deleteButton], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        
        addSubview(topStack)
  
        
        topStack.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil,  paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        let width =  self.frame.width / 5
        
        
        productImageView.anchor(top: topStack.bottomAnchor, left: self.leadingAnchor, right: nil, bottom: nil ,paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: width, height: width)
        
      
   
        
        
        
        addQuantityButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addQuantityButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        removeQuantityButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        removeQuantityButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        quantyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let quantityStack  = StackManager.createStackView(with: [ removeQuantityButton, quantyLabel, addQuantityButton ], axis: .horizontal, spacing: 0, distribution: .fillEqually, alignment: .bottom)
        
       
        
        
        
    
        let labelStacks = StackManager.createStackView(with: [ productPriceLabel, productVariantAndQuantiy, personalizationTextView ], axis: .vertical, spacing: 0, distribution: .fillEqually, alignment: .fill)
        
        let containerStack  = StackManager.createStackView(with: [ labelStacks  ], axis: .horizontal, spacing: 0, distribution: .equalSpacing, alignment: .fill)
        
        addSubview(containerStack)
        containerStack.anchor(top: self.productImageView.topAnchor, left: self.productImageView.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        containerStack.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor).isActive = true
        
        addSubview(quantityStack)
        quantityStack.anchor(top: containerStack.bottomAnchor, left: nil, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: -10, paddingBottom: -20, width: nil, height: nil)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
       
        
        
            
        
        
            
            
           
                
                
                
    }
    
    
}
