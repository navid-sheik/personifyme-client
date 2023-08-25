//
//  ProductShopInfo.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 22/08/2023.
//

import Foundation


import UIKit



protocol ProductShopInfoDelegate : class{
    func didTapShopButton()
    func didTapFollowButton()

}



class ProductShopInfo  : UIView {
    
    weak var delegate : ProductShopInfoDelegate?
    var shop : Shop?{
        didSet{
            guard let shop =  shop else { return }
            if let imageFirstUrl =  shop.image{
                self.mainImage.loadImageUrlString(urlString: imageFirstUrl)
            }
            let name = shop.name
            self.shopName.text =  name.prefix(13).count > 12 ? String(name.prefix(8)) : name
            self.country.text = shop.location
            guard let user_id  = UserDefaults.standard.object(forKey: "user_id") as? String else {return}
            if ((shop.followers?.contains(user_id)) == true){
                self.followButton.setTitle("Unfollow", for: .normal)
        
                
            }else {
                self.followButton.setTitle("Follow", for: .normal)
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
    
    
    let shopButton : CustomButton = {
        
        let customButton = CustomButton(title: "Shop", hasBackground: true, fontType: .small)
        return customButton
    }()
    
    let followButton : CustomButton = {
        
        let customButton = CustomButton(title: "Follow", hasBackground: true, fontType: .small)
        return customButton
    }()
    
    

    
    
    let shopName :  UILabel = {
        let label =  UILabel()
        label.text = "Shop Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
    
        return label
    }()
    
    let country :  UILabel = {
        let label =  UILabel()
        label.text = "United States"
        label.font = UIFont.systemFont(ofSize: 14)
    
        return label
    }()
    
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        shopButton.addTarget(self, action: #selector(shopButtonTapped), for: .touchUpInside)
        followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        addSubview(mainImage)
        mainImage.anchor(top: self.topAnchor, left: self.leadingAnchor, right: nil, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 90, height: 90)
        mainImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let buttonStack  = StackManager.createStackView(with: [shopButton, followButton], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .top)
//        buttonStack.backgroundColor = .blue
        
        let stack  = StackManager.createStackView(with: [shopName,country,  buttonStack], axis: .vertical, spacing: 8, distribution: .fillProportionally, alignment: .fill)
//        stack.backgroundColor = .brown
//        shopName.backgroundColor = .green
        addSubview(stack)
        
        stack.anchor(top: self.topAnchor, left: mainImage.trailingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func shopButtonTapped(){
        print("Shop")
        delegate?.didTapShopButton()
    }
    
    @objc func followButtonTapped(){
        print("Follow")
        delegate?.didTapFollowButton()
    }
    
    

}

