//
//  ModerationCellView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 20/08/2023.
//

import Foundation

import UIKit

protocol ModerationCellViewDelegate: class {
    func approveItem(on cell: ModerationCellView, with product: Product)
    func disapproveItem(on cell: ModerationCellView, with product: Product)
}

class ModerationCellView : CustomCell{
    
    weak var delegate : ModerationCellViewDelegate?
    
    var product :  Product?{
        didSet{
            guard let product =  product else { return }
            if let imageFirstUrl =  product.images.first{
                self.mainImage.loadImageUrlString(urlString: imageFirstUrl)
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
    
    
    
    let approveButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.tintColor =  UIColor.green
        
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let rejectButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.tintColor =  UIColor.red
        
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    
    
    
    
    override func setUpCell() {
        super.setUpCell()
        
        
        approveButton.addTarget(self , action: #selector(handleApproveButton), for: .touchUpInside)
        rejectButton.addTarget(self , action: #selector(handleRejetcButton), for: .touchUpInside)
        setUpUI()
        
        
     
        
        
        
    
        
    }
    func setUpUI(){
        contentView.addSubview(mainImage)
        
        let width = self.frame.width
        mainImage.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom :  nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: width, height: width)
        
        
        let stackView  = StackManager.createStackView(with: [approveButton, rejectButton], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .fill)
        
        contentView.addSubview(stackView)
        stackView.anchor(top: mainImage.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 35)
        
        
        
    }
    
    
    @objc func handleApproveButton (){
        print ("Approved")
        guard let product  = product else {return}
        delegate?.approveItem(on: self, with: product)
    }
    
    
    
    @objc func handleRejetcButton(){
        print("Not approved")
        guard let product  = product else {return}
        delegate?.disapproveItem(on: self, with: product)
    }

}
