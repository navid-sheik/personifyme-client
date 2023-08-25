//
//  ProfileOrders.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation
import UIKit

protocol  ProfileOrdersDelegate : class {
    func didTapProduced()
    func didTapToBeShipped()
    func didTapDelivered()
    func didTapRefund()
}




class ProfileOrders : UIView {
    
    weak var delegate : ProfileOrdersDelegate?
    
    
    
    
    //MARK: - PROPERTIES
    
    let ordersLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Orders"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
   
    
    
    //MARK: - COMPONENTS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  DesignConstants.secondaryColor
        
        
        addSubview(ordersLabel)
        ordersLabel.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        

    
        
        //To be shipped
        let produced =  createImageStacker(imageName: "shippingbox", title: "In Production")
        produced.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProduced)))
        
        
        //Shipped Carrigae
        let tobeshipped =  createImageStacker(imageName: "airplane.circle", title: "Shipped")
        tobeshipped.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleToBeShipped)))
        
        
        //Delivered
        let delivered =  createImageStacker(imageName: "shippingbox", title: "Delivered")
        delivered.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hadleToBeDelivered)))
        
        
        
        //Refund
        let refund =  createImageStacker(imageName: "shippingbox", title: "Refund")
        
        refund.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleToBeRefund)))
        
        
        
      
        
        let stackView = StackManager.createStackView(with: [produced, tobeshipped, delivered, refund], axis: .horizontal, spacing: 0, distribution: .fillEqually, alignment: .center)
        
        
        addSubview(stackView)
        
        
        stackView.anchor( top: ordersLabel.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 25, paddingLeft: 0,paddingRight: 0, paddingBottom: -10, width: nil, height: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImageStacker (imageName : String, title : String) -> UIStackView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = DesignConstants.primaryColor
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 14)
        
        let stackView = StackManager.createStackView(with: [imageView, label], axis: .vertical, spacing: 4, distribution: .fillProportionally, alignment: .center)
    
        return stackView
    }
    
    
    @objc func handleProduced(){
        delegate?.didTapProduced()
    }
    
    @objc func handleToBeShipped(){
        delegate?.didTapToBeShipped()
        
    }
    @objc func hadleToBeDelivered(){
        delegate?.didTapDelivered()
        
    }
    @objc func handleToBeRefund(){
        
        delegate?.didTapRefund()
    }
    
    
    
}
