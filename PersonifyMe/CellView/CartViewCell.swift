//
//  CartViewCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 06/08/2023.
//

import Foundation
import UIKit

protocol CartViewCellDelegate: class {
    func deleteCartItem(_ cell: CartViewCell, withItemCartId cartItemId: String)
    func updateCartItem(_ cell: CartViewCell, withItemCartId cartItemId: String, cartItem: CartItem)
}

class CartViewCell : UITableViewCell{
    
    weak var delegate : CartViewCellDelegate?
    
    var cartItem : CartItem? {
        didSet{
            guard let cartItem =  cartItem else {return}
            self.configureCell(cartItem)
            
//            guard let cartItem = cartItem else {return}
//            productTitleLabel.text = cartItem.productId
//            productPriceLabel.text = "$\(cartItem.price)"
//            productImageView.loadImage(urlString: cartItem.productId)
        }
    }
    
    
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
    
    var productTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A Unique Embodiment of Your Personal Style,Crafted with Precision, Simple Kind Something"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 2
        return label
    }()
    
    var productPriceLabel : UILabel = {
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
    
  
    
    
    var quatity : Int? = 1{
        didSet{
            if quatity == 1 {
                removeQuantityButton.isEnabled = false
                removeQuantityButton.tintColor = .systemGray4
            }else{
                removeQuantityButton.isEnabled = true
                removeQuantityButton.tintColor = .systemBlue
            }
            
            guard let quatityText = quatity else {return}
            
            quantyLabel.text = "\(quatityText)"
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Components
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.quatity = 1
        deleteButton.addTarget(self, action: #selector(removeItemFromCart), for: .touchUpInside)
        addQuantityButton.addTarget(self, action: #selector(increaseItemQuantiy), for: .touchUpInside)
        removeQuantityButton.addTarget(self, action: #selector(decreaseItemQuantity), for: .touchUpInside)
        setupUI()
        
    }
   
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {

        contentView.addSubview(productImageView)
        contentView.addSubview(productTitleLabel)
    //    contentView.addSubview(productPriceLabel)
    //    contentView.addSubview(productVariantAndQuantiy)
    //    contentView.addSubview(personalizationTextView)
        contentView.addSubview(deleteButton)
    //    contentView.addSubview(addQuantityButton)
    //    contentView.addSubview(quantyLabel)
    //    contentView.addSubview(removeQuantityButton)

        deleteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let topStack  = StackManager.createStackView(with: [ productTitleLabel, deleteButton], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .fill)

        contentView.addSubview(topStack)

        topStack.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil,  paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

        let width = self.frame.width / 5

        productImageView.anchor(top: topStack.bottomAnchor, left: contentView.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: 0, paddingBottom: 0, width: width, height: width)

        addQuantityButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addQuantityButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

        removeQuantityButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        removeQuantityButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

        quantyLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let quantityStack  = StackManager.createStackView(with: [ removeQuantityButton, quantyLabel, addQuantityButton ], axis: .horizontal, spacing: 0, distribution: .fillEqually, alignment: .bottom)

        let labelStacks = StackManager.createStackView(with: [ productPriceLabel, productVariantAndQuantiy, personalizationTextView ], axis: .vertical, spacing: 0, distribution: .fillEqually, alignment: .fill)

        let containerStack  = StackManager.createStackView(with: [ labelStacks  ], axis: .horizontal, spacing: 0, distribution: .equalSpacing, alignment: .fill)

        contentView.addSubview(containerStack)
        containerStack.anchor(top: productImageView.topAnchor, left: productImageView.trailingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

        containerStack.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor).isActive = true

        contentView.addSubview(quantityStack)
        quantityStack.anchor(top: containerStack.bottomAnchor, left: nil, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: -10, paddingBottom: -20, width: nil, height: nil)
    }
    
    func configureCell(_ cartItem : CartItem){
        self.productTitleLabel.text = cartItem.productId.productTitle
        self.productPriceLabel.text =  "\(cartItem.price)"
        self.productImageView.loadImageUrlString(urlString: cartItem.productId.productImages[0])
        self.quatity  = cartItem.quantity
        let resultString = cartItem.variations.map { "\($0.variant): \($0.value)" }.joined(separator: ", ")

        self.productVariantAndQuantiy.text = "\(resultString)"
        self.personalizationTextView.text = "\(cartItem.customizationOptions[0])"
    
        
        
    }
    @objc func removeItemFromCart(){
        print("remove item from cart")
        guard let id = self.cartItem?.cartItemId else {return}
        delegate?.deleteCartItem(self, withItemCartId: id)
    }
    
    @objc func increaseItemQuantiy(){
        guard let id = self.cartItem?.cartItemId else {return}
        guard let quantity  = self.quatity else {return}
        let newQuantity = quantity + 1
//        self.quatity =  newQuantity
        self.cartItem?.quantity = newQuantity
        delegate?.updateCartItem(self, withItemCartId: id, cartItem: self.cartItem!)
        
    }
    
    @objc func decreaseItemQuantity(){
        guard let id = self.cartItem?.cartItemId else {return}
        guard let quantity  = self.quatity else {return}
        let newQuantity = quantity - 1
        if newQuantity == 0 {
            return
        }
//        self.quatity =  newQuantity
        self.cartItem?.quantity = newQuantity
        delegate?.updateCartItem(self, withItemCartId: id, cartItem: self.cartItem!)
        
    }
    
    
}
