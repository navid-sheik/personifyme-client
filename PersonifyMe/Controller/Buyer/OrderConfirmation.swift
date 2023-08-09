//
//  OrderConfirmation.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 09/08/2023.
//

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

class OrderConfirmation: UIViewController {
    
    
    let productCellIdentifier : String = "productCellIdentifier"
    // MARK: - Components
    // Here you add all components
    let thankyouLabel : UILabel = {
        let label = UILabel()
        label.text = "Thank You"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = """
Hi User, we're getting your order ready to be shipped. We will notify you when it has been sent. Please allow  (*-* days) business days for the production as the item is made especially for you.
"""
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
 
    
    let continueShopping : CustomButton = {
        let custom = CustomButton(title: "CONTINUE SHOPPING", hasBackground: true, fontType: .small)
        return custom
    }()
    
    let tableView : DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    
    
    let subTotalPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subtotal:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let subTotalValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let shippingPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let shippingValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let totalPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let totalValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.gray
        return label
    }()
    
    let customINformationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Customer Information"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let shippingAddressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping Address"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let shippingAddressValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Navid Sheikh \n86 Ferenz Road,E61LL\n London United Kingdom,\n+447405341412"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    
    
    let billingAddressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Billing Address"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let billingAddressValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Navid Sheikh \n86 Ferenz Road,E61LL\n London United Kingdom,\n+447405341412"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    
    
    
    
    
    
    //MARK: MAIN SCROLLVIEW
    lazy var containerScrollView :  UIScrollView =  {
        let sv =  UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.flashScrollIndicators()
        sv.isUserInteractionEnabled = true
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    let contentView : UIView =  {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    
    
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        setNavigationBar()
        setUpTableView()
        setupUI()
    }
    
    func setNavigationBar (){
            navigationController?.navigationBar.isHidden =  true
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(SingleOrderProduct.self, forCellReuseIdentifier: productCellIdentifier)
        
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(contentView)
        containerScrollView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
        
        
        contentView.addSubview(thankyouLabel)
        
        thankyouLabel.anchor( top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 30, paddingLeft: 10 ,paddingRight: 0, paddingBottom: -10, width: nil, height: nil)
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.anchor( top: thankyouLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
        let width = self.view.frame.width / 2
        contentView.addSubview(continueShopping)
        continueShopping.anchor( top: descriptionLabel.bottomAnchor, left: nil, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: width, height: 40)
        
        continueShopping.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        contentView.addSubview(tableView)
        tableView.anchor( top: continueShopping.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
        let subTotalStack = StackManager.createStackView(with: [subTotalPlaceholder,subTotalValue] , axis: .horizontal, spacing: 0, distribution: .fill, alignment: .fill)
        
        let shippingStack = StackManager.createStackView(with: [shippingPlaceholder,shippingValue] , axis: .horizontal, spacing: 0, distribution: .fill, alignment: .fill)
        
        
        let total  =  StackManager.createStackView(with: [totalPlaceholder,totalValue] , axis: .horizontal, spacing: 0, distribution: .fill, alignment: .fill)
      
        
        let customInformationStack = StackManager.createStackView(with: [subTotalStack, shippingStack, total] , axis: .vertical, spacing: 10, distribution: .fillProportionally, alignment: .fill)
        
        
        
        
        
        
        
        
        
        
        contentView.addSubview(customInformationStack)
        
        
        let widthStack  =  self.view.frame.width / 2
        customInformationStack.anchor( top: tableView.bottomAnchor, left: nil, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: widthStack, height: nil)
        
        
        
        
        
        
        let shippingAddressStack = StackManager.createStackView(with: [shippingAddressLabel,shippingAddressValue] , axis: .vertical, spacing: 10, distribution: .fillProportionally, alignment: .fill)
        
        let billingAddressStack = StackManager.createStackView(with: [billingAddressLabel,billingAddressValue] , axis: .vertical, spacing: 10, distribution: .fillProportionally, alignment: .fill)
        
        
        
        let addressStack = StackManager.createStackView(with: [shippingAddressStack,billingAddressStack] , axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .fill)
        
        
        contentView.addSubview(customINformationLabel)
        customINformationLabel.anchor( top: customInformationStack.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width:  nil, height: nil)
        
        
        contentView.addSubview(addressStack)
        addressStack.anchor( top: customINformationLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
   
        
        
        
        
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}


extension OrderConfirmation : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier) as! SingleOrderProduct
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    

    
    
    
}

