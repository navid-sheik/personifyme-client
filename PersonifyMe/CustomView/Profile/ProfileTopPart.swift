//
//  ProfileTopPart.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation
import UIKit


class ProfileTopPart : UIView {
    
    
    //MARK: - PROPERTIES
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius =  .init(10)
        
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    let  fullNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Navid Sheikh"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let  countryLabel : UILabel = {
        let label = UILabel()
        label.text = "United Kingdom"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let  emailLabel : UILabel = {
        let label = UILabel()
        label.text = "navidsheikh54@gmail.com"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    
    
    //MARK: - COMPONENTS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  UIColor.init(red: 0.949, green: 0.949, blue: 0.97, alpha: 1.0)
        

    
        
        
        let wisthList =  createImageStacker(imageName: "heart", title: "Wish List")
        //Shop
        let shopList =  createImageStacker(imageName: "bag", title: "Shop")
        //Reviews
        let reviewList =  createImageStacker(imageName: "star", title: "Reviews")
        //Messages
        let messageList =  createImageStacker(imageName: "message", title: "Messages")
        
        let stackView = StackManager.createStackView(with: [wisthList, shopList, reviewList, messageList], axis: .horizontal, spacing: 0, distribution: .fillEqually, alignment: .center)
        
  
        
        let stackView2 = StackManager.createStackView(with: [fullNameLabel, countryLabel, emailLabel], axis: .vertical, spacing: 4, distribution: .fillEqually, alignment: .fill)
        
        
        
        mainImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        let stackView3 = StackManager.createStackView(with: [mainImage, stackView2], axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .center)
        
        addSubview(stackView3)
        
        stackView3.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
        addSubview(stackView)
        
        
        stackView.anchor( top: stackView3.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 25, paddingLeft: 0,paddingRight: 0, paddingBottom: -10, width: nil, height: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImageStacker (imageName : String, title : String) -> UIStackView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        
        let stackView = StackManager.createStackView(with: [imageView, label], axis: .vertical, spacing: 4, distribution: .fillProportionally, alignment: .center)
    
        return stackView
    }
    
    
}
