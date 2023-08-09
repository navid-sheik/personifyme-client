//
//  ProfileOrders.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation
import UIKit


class ProfileOrders : UIView {
    
    
    //MARK: - PROPERTIES
    
    let ordersLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Orders"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
   
    
    
    //MARK: - COMPONENTS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  UIColor.init(red: 0.949, green: 0.949, blue: 0.97, alpha: 1.0)
        
        
        addSubview(ordersLabel)
        ordersLabel.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        

    
        
        //To be shipped
        let produced =  createImageStacker(imageName: "shippingbox.fill", title: "In Production")
        
        
        //Shipped Carrigae
        let tobeshipped =  createImageStacker(imageName: "airplane", title: "Shipped")
        
        
        //Delivered
        let delivered =  createImageStacker(imageName: "shippingbox", title: "Delivered")
        
        
        
        
        //Refund
        let refund =  createImageStacker(imageName: "shippingbox", title: "Refund")
        
        
      
        
        let stackView = StackManager.createStackView(with: [produced, tobeshipped, delivered, refund], axis: .horizontal, spacing: 0, distribution: .fillEqually, alignment: .center)
        
        
        addSubview(stackView)
        
        
        stackView.anchor( top: ordersLabel.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 25, paddingLeft: 0,paddingRight: 0, paddingBottom: -10, width: nil, height: nil)
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
