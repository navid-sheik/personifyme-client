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
    
    weak var delegate: CartViewControllerDelegate?
    var order : Order{
        didSet{
            print("The order is ready")
          
            
        }
    }
    
    var orderItems : [OrderItem]{
        didSet{
            print("Teh order item")
            self.tableView.reloadData()
        }
        
    }
    
    
    
    let productCellIdentifier : String = "productCellIdentifier"
    // MARK: - Components
    // Here you add all components
    let thankyouLabel : UILabel = {
        let label = UILabel()
        label.text = "Thank you"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = DesignConstants.textColor
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = """
Hi User, we're getting your order ready to be shipped. We will notify you when it has been sent. Please allow 7-10 business days for the production as the item is made especially for you.
"""
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
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
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    let subTotalValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    let shippingPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    let shippingValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    let totalPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    let totalValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    let customINformationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Customer Information"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    let shippingAddressLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shipping Address"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = DesignConstants.textColor
        return label
    }()
    
    
    let shippingAddressValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Navid Sheikh \n86 Ferenz Road,E61LL\n London United Kingdom,\n+447405341412"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = DesignConstants.textColor
        label.numberOfLines = 0
        return label
    }()
    
    
//
//    let billingAddressLabel : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Billing Address"
//        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.textColor = DesignConstants.textColor
//        return label
//    }()
//
//
//    let billingAddressValue : UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Navid Sheikh \n86 Ferenz Road,E61LL\n London United Kingdom,\n+447405341412"
//        label.font = UIFont.boldSystemFont(ofSize: 10)
//        label.textColor = DesignConstants.textColor
//        label.numberOfLines = 0
//        return label
//    }()
//
    
    
    
    
    
    
    
    
    
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
    
    init(orderTotal : Order, orderItems : [OrderItem]) {
        self.order = orderTotal
        self.orderItems = orderItems
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        continueShopping.addTarget(self, action: #selector(handleContinueShopping), for: .touchUpInside)
        continueShopping.isEnabled = true
        setNavigationBar()
        setUpTableView()
        populateData()
        setupUI()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden =  true
    }
    
    
    
    
    
    func setNavigationBar (){
            navigationController?.navigationBar.isHidden =  true
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.register(SingleOrderProduct.self, forCellReuseIdentifier: productCellIdentifier)
        
    }
    private func populateData (){
        print(order.orderTotal)
        if let orderTotal = order.orderTotal{
            self.totalValue.text = "$\(StripeManager.convertStripeAmountToDouble(Int(orderTotal)) )"
        }
        
        if let shippingCost = order.shippingCost{
            self.shippingValue.text = "$\(StripeManager.convertStripeAmountToDouble(Int(shippingCost)) )"
        }
        
        if let shippingCost = order.shippingCost, let orderTotal = order.orderTotal{
            let subTotal = orderTotal - shippingCost
            self.subTotalValue.text = "$\(StripeManager.convertStripeAmountToDouble(Int(subTotal)) )"
        }
      
//
//            self.shippingValue.text = "\(order.shippingCost)"
//            self.subTotalValue.text = "\(order.orderTotal)"
        self.shippingAddressValue.text = order.shippingDetails?.formattedAddress()
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
        
        thankyouLabel.anchor( top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 40, paddingLeft: 10 ,paddingRight: 0, paddingBottom: -10, width: nil, height: nil)
        
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
        
//        let billingAddressStack = StackManager.createStackView(with: [billingAddressLabel,billingAddressValue] , axis: .vertical, spacing: 10, distribution: .fillProportionally, alignment: .fill)
//
        
        
        let addressStack = StackManager.createStackView(with: [shippingAddressStack] , axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .fill)
        
        
        contentView.addSubview(customINformationLabel)
        customINformationLabel.anchor( top: customInformationStack.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width:  nil, height: nil)
        
        
        contentView.addSubview(addressStack)
        addressStack.anchor( top: customINformationLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
   
        
        
        
        
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    @objc func handleContinueShopping(){
        print("Clicking")
        print ("Handle shopping")
        delegate?.emptyCart()
        self.dismiss(animated: true) { [weak self] in
               // After dismissing, switch to the desired tab
            print("Something")
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        // Access the root view controller of the window associated with the window scene
                        if let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController {
                            // Set the desired tab index
                            tabBarController.selectedIndex = 0
                        }
                    }
        }
    }
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}


extension OrderConfirmation : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: productCellIdentifier) as! SingleOrderProduct
        cell.selectionStyle = .none
        let orderItem  =  orderItems[indexPath.row]
        cell.productTitleLabel.text = orderItem.product.title
        cell.priceLabel.text = "$\(orderItem.product.price)"
        cell.variantLabel.text = orderItem.variant?.map { $0.value }.joined(separator:", ")
        cell.quantityLabel.text =  "x\(orderItem.quantity)"
        if let imageUrl =  orderItem.product.images.first  {
            cell.productImageView.loadImageUrlString(urlString: imageUrl)
        }
        if let personalizationText  = orderItem.customizationOptions?.first{
            cell.personalizationLabel.text = "Text: \(personalizationText )"

        }
        
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    

    
    
    
}

