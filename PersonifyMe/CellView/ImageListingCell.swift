//
//  ImageListingCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//
//
//  SellerMenuCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 31/07/2023.
//



import Foundation
import UIKit


class ImageListingCell: CustomCell {
    
    weak var delegate: CreateListingDelegate?
    
    var isPlaceholder : Bool = false {
        didSet{
            if isPlaceholder{
                mainImage.image =  UIImage(named: "image-placeholder")
                closeBUtton.isHidden = true
            }else{
                closeBUtton.isHidden = false
            }
        }
    }
    override func prepareForReuse() {
        closeBUtton.isHidden = false
        isPlaceholder = false
    }
    
    
   
    let mainImage : CustomImageView  = {
        let imageView  = CustomImageView()
        imageView.image =  UIImage(named: "image-placeholder")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor =  .init(white: 0.9, alpha: 0.5)
        return imageView
    }()
    
    let closeBUtton :  UIButton =  {
       let closeButton  =  UIButton()
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    let containingVieww : UIView =  {
        let view  =  UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth =  1
        view.layer.cornerRadius = 2
      
        return view
    }()
    
    
    
  
    
    override func setUpCell() {
        super.setUpCell()
        self.backgroundColor =  .brown
        closeBUtton.addTarget(self, action: #selector(handleDeleteImage), for: .touchUpInside)
        addSubview(containingVieww)
   
        containingVieww.anchor( top: self.topAnchor, left: self.leadingAnchor , right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        containingVieww.addSubview(mainImage)
        containingVieww.addSubview(closeBUtton)
        
//
//
//
//
//
//
        mainImage.anchor(top: self.containingVieww.topAnchor, left: containingVieww.leadingAnchor, right: containingVieww.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: nil, width: nil, height: nil)
        mainImage.heightAnchor.constraint(equalTo: containingVieww.heightAnchor).isActive = true
        

        closeBUtton.anchor( top: containingVieww.topAnchor, left: nil , right: containingVieww.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 0,paddingRight: -5, paddingBottom: 0, width: 25, height: 25)


        
   
    }
    
    
    @objc func handleDeleteImage (){
        delegate?.didTapCell(self)

    }
}

