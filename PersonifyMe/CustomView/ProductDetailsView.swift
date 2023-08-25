//
//  ProductDetailsView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 22/08/2023.
//



import Foundation


import UIKit





class ProductDetailsView  : UIView {
    
   
    let mainTitle : UILabel = {
        let label = UILabel()
        label.text = "Product Details"
        label.font = UIFont.systemFont(ofSize: 18)
         label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    
    let conditionIcon : UIImageView = {
        let imageView = UIImageView ()
        imageView.image =       UIImage(systemName: "tag.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor =  DesignConstants.primaryColor
        
    
        return imageView
    }()
    
    
    let conditionLabel : UILabel = {
        let label = UILabel()
        label.text = "Condition"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
         label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    
    let categoryIcon : UIImageView = {
        let imageView = UIImageView ()
        imageView.image =       UIImage(systemName: "square.grid.2x2.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor =  DesignConstants.primaryColor
    
        return imageView
    }()
    
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
         label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    
    let dispatchesIcon : UIImageView = {
        let imageView = UIImageView ()
        imageView.image =       UIImage(systemName: "train.side.front.car")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor =  DesignConstants.primaryColor
    
        return imageView
    }()
    
    
    let dispatchesLabel : UILabel = {
        let label = UILabel()
        label.text = "Dispatches from United States"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
         label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    let returnIcon : UIImageView = {
        let imageView = UIImageView ()
        imageView.image =       UIImage(systemName: "return")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor =  DesignConstants.primaryColor
    
        return imageView
    }()
    
    
    let returnLabel : UILabel = {
        let label = UILabel()
        label.text = "Return & Exchange"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
         label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    let exchangeIcon : UIImageView = {
        let imageView = UIImageView ()
        imageView.image =       UIImage(systemName: "shippingbox.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor =  DesignConstants.primaryColor
    
        return imageView
    }()
    
    
    let exchangeLabel : UILabel = {
        let label = UILabel()
        label.text = "Return & Exchange"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(mainTitle)
        mainTitle.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        
        conditionIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        conditionIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        categoryIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        categoryIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        dispatchesIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        dispatchesIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        returnIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        returnIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        exchangeIcon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        exchangeIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        let conditionStack  = StackManager.createStackView(with: [conditionIcon, conditionLabel], axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .center)
        
        let categoryStack  = StackManager.createStackView(with: [categoryIcon, categoryLabel], axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .center)
        
        
        let dispatchStack  = StackManager.createStackView(with: [dispatchesIcon, dispatchesLabel], axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .center)
        
        let returnStack  = StackManager.createStackView(with: [returnIcon, returnLabel], axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .center)
        
        let exchangeStack  = StackManager.createStackView(with: [exchangeIcon, exchangeLabel], axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .center)
        
//        addSubview(conditionStack)
//        addSubview(categoryStack)
//        addSubview(dispatchStack)
//        addSubview(returnStack)
       
        
        
        let stackManager =  StackManager.createStackView(with: [conditionStack, categoryStack, returnStack, exchangeStack, dispatchStack], axis: .vertical, spacing: 15, distribution: .fillProportionally, alignment: .fill)
        addSubview(stackManager)
        stackManager.anchor(top: mainTitle.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//        conditionStack.anchor(top: mainTitle.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
//        categoryStack.anchor(top: conditionStack.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
//        dispatchStack.anchor(top: categoryStack.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
//        returnStack.anchor(top: dispatchStack.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
        
        
        
    
       
        
        
        
        
    }
    
    func  configure( condition : String,  category : String , disptaches : String, returns : Bool, exchanhe: Bool){
        self.conditionLabel.text = condition
        self.categoryLabel.text = category
        self.dispatchesLabel.text =  "Dispatches from \(disptaches)"
        self.returnLabel.text = returns ?  "Returns Accepted" : "Returns Not Accepted"
        self.exchangeLabel.text = returns ?  "Exchange Accepted" : "Exchange Not Accepted"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

