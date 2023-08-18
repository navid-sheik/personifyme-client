//
//  ProductLikeCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import Foundation
import UIKit


protocol ProductLikeCellDelegate : class {
    func handleUnlike(cell : CustomCell)
}


class ProductLikeCell :  CustomCell{
    
    weak var delegate : ProductLikeCellDelegate?
    
    
    
    var product : Product?{
        didSet{
            guard let product = product else {return}
            self.configureCell(product)
        }
    }
    
    let favouriteButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = false
        button.isHidden = false
        button.isUserInteractionEnabled = true

//        button.backgroundColor = .brown
//

        // Set the background color for the button
//        button.backgroundColor = .lightGray
        
        return button
    }()
    
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    override func setUpCell() {
        //stylingCell()
        favouriteButton.addTarget(self, action: #selector(handleUnLikeProduct), for: .touchUpInside)
        contentView.addSubview(mainImage)
        contentView.addSubview(favouriteButton)
        mainImage.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        favouriteButton.anchor(top: contentView.topAnchor, left: nil, right: contentView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 40, height: 40)
        
        
    }
    
    
    private func stylingCell(){
        self.contentView.backgroundColor =  .black
        self.contentView.layer.borderWidth =  1.0
        self.contentView.layer.borderColor =  UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor =  UIColor.black.cgColor
        self.layer.shadowOffset =  CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius =  2.0
        self.layer.shadowOpacity =  0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    @objc func handleUnLikeProduct(){
        print("Like Product")
        favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        guard let productId = product?.productId else {return}
        Service.shared.unlikeProduct(productId: productId, expecting: ApiResponse<String>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{

            case .success(let response):
                print(response)
                guard let productId2  = response.data else {return}
                
                DispatchQueue.main.async {
                    
                    if productId == productId2 {
                        UIView.transition(with: self.favouriteButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                              self.favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                          }, completion: nil)
                    }
                    self.delegate?.handleUnlike(cell: self)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
        
       

        
    }
    
    func configureCell(_ product : Product){
        
        if  let imageUrl =  product.images.first {
            mainImage.loadImageUrlString(urlString: imageUrl)
        }
        
        
       
        
    }
    
}
