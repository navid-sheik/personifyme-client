//
//  ManageOrderCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
import UIKit



protocol ManageOrderCellDelegate : class{
    func showTrackingpage(for cell: ManageOrderCell)

    
}
class ManageOrderCell : UITableViewCell{
    
    weak var delegate : ManageOrderCellDelegate?
    
    var orderItem : OrderItem?{
        didSet{
            print("Something")
            guard let orderItem =  orderItem else {return}
            self.configureCell(orderItem)
        }
    }

    let productImageView : CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .systemBackground
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "placeholder")
        
        return imageView
    }()
    
    let productTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A Unique Embodiment of Your Personal Style,Crafted with Precision, Simple Kind Something"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.numberOfLines = 1
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
    
    let personalizationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Text : My name is "
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    
    
    let shippingAddressPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    let shippingAddressValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Navid Sheikh  \n86 Ferenz Road,E61LL\n London United Kingdom,\n+447405341412"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    
    let amountPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Amount"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    let amountValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "39.99"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.textAlignment = .right
        return label
        
    }()
    
    let statusPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    let statusValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Paid"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.textAlignment = .right
    
        return label
    }()
    let shippingPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        
        return label
    }()
    
    let shippingValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2.99"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.textAlignment = .right
        return label
    }()
    
    let buttonMenu : UIButton =  {
        let button =  UIButton()
        button.setImage(UIImage(systemName: "text.justify.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .gray
        
        
        
        return button
    }()
    
    private let trackingBUtton : CustomButton = {
        let button = CustomButton(title: "ADD TRACKING", hasBackground: true, fontType: .small)

        return button
    }()
    
    let trackingTextField :  UITextField = {
        let textField  = UITextField()
        textField.backgroundColor =  .secondarySystemBackground
        textField.layer.cornerRadius =  4
        textField.text =  "1"
        
        textField.returnKeyType =  .next
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textAlignment = .center
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
        
    }()
    
    let optionButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor =  UIColor.init(red: 0.949, green: 0.949, blue: 0.97, alpha: 1.0)
        trackingBUtton.addTarget(self, action: #selector(addTracking), for: .touchUpInside)
        setupUI()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        let width = self.frame.width / 4
        contentView.addSubview(productImageView)
        productImageView.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, right: nil, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: 0, paddingBottom: 0, width: width, height: width)
        
        
        contentView.addSubview(buttonMenu)
        buttonMenu.anchor(top: contentView.topAnchor, left: nil, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: -5, paddingBottom: 0, width: 20, height: 20)
//        buttonMenu.backgroundColor =  .brown
        
        let stackTopPart = StackManager.createStackView(with: [productTitleLabel, productVariantAndQuantiy, personalizationLabel], axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .fill)
        
        contentView.addSubview(stackTopPart)
        stackTopPart.anchor(top: contentView.topAnchor, left: productImageView.trailingAnchor, right: buttonMenu.leadingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        
        let shippingStack = StackManager.createStackView(with: [shippingAddressPlaceholder, shippingAddressValue], axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .fill)

        let amountStack = StackManager.createStackView(with: [amountPlaceholder, amountValue], axis: .horizontal, spacing: 5, distribution: .fillEqually, alignment: .center)
        
        let statusStack = StackManager.createStackView(with: [statusPlaceholder, statusValue], axis: .horizontal, spacing: 5, distribution: .fillEqually, alignment: .center)
        
        let shippingCostStack = StackManager.createStackView(with: [shippingPlaceholder, shippingValue], axis: .horizontal, spacing: 0, distribution: .fillEqually, alignment: .center)

        let mainInfoStack = StackManager.createStackView(with: [amountStack, statusStack, shippingCostStack], axis: .vertical, spacing: 5, distribution: .fillEqually, alignment: .fill)
        
        let twoColumnStack = StackManager.createStackView(with: [shippingStack, mainInfoStack], axis: .horizontal, spacing: 5, distribution: .fillProportionally, alignment: .bottom)
        
        contentView.addSubview(twoColumnStack)
        twoColumnStack.anchor(top: productImageView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5, paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        
        let widthButton = self.frame.width / 3
        contentView.addSubview(trackingBUtton)
        trackingBUtton.anchor(top: twoColumnStack.bottomAnchor, left: nil, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 20, paddingLeft: 0, paddingRight: -5, paddingBottom: -10, width: widthButton, height: 30)
    }

    
    
    func configureCell (_ orderItem : OrderItem){
        if let imageString = orderItem.product.images.first{
            self.productImageView.loadImageUrlString(urlString: imageString)
        }
        self.shippingAddressValue.text =  orderItem.shippingDetails?.formattedAddress()
        
        let variantOptions = self.orderItem?.variant?.map { $0.value }.joined(separator:", ")
      
        
   
        self.productVariantAndQuantiy.text =   "\(variantOptions ?? "") x\(String(orderItem.quantity))"
        self.productTitleLabel.text = self.orderItem?.product.title
        if let personalizationText =   self.orderItem?.customizationOptions?.first{
            self.personalizationLabel.text = "Text: \(personalizationText)"
        }
        
        self.amountValue.text = "$\(orderItem.total)"
        self.statusValue.text = orderItem.status == .Processing ? "Paid" : "Shipped"
        
        self.shippingValue.text = "$0.00"
    
      
        
//        self.
//        if let quantity = self.orderItem?.quantity, let price = self.orderItem?.price{
//            cell.quantityLabel.text =  "x\(quantity)"
//            cell.priceLabel.text =  "$\(price)"
//        }
        
       
        
    }
    
    @objc func addTracking(){
        print("Add tracking")
        delegate?.showTrackingpage(for: self)

//        let vc = AddTrackingController()
//
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.delegate = self
////        vc.modalTransitionStyle = .crossDissolve
////        vc.modalPresentationStyle = .popover
//
//        //representative of actually presented VC
//        self.definesPresentationContext = true //*** adding this line should solve your issue ***
//        self.present(vc, animated: true, completion: nil)
//
        
    }
    
    
}

