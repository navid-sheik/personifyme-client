//
//  OrderDetails.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//
//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

class OrderDetailsController: UIViewController {
    
    
    var orderItem : OrderItem?{
        didSet{
            guard let orderItem =  orderItem else {return}
            self.configureUI(orderItem)
            self.tableViewProducts.reloadData()
        }
    }
    
    let productinfoCellIdentifier : String = "productinfoCell"
    let orderStatusCellIdentifer : String =  "orderStatusCell"
    let orderInfoCellIdentifier : String =  "orderInfoCellIdentifier"
    let orderPersonalizationCellIdentifier : String = "orderPersonalizationCellIdentifier"
    
    //TOP PART
    
    let statusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delivered "
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let statusMessage : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Status Message "
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    
    
    
    let tableViewProducts:  DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        
    
       
        return tableView
    }()
    
    
    
    let shopLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Shop"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.numberOfLines = 1
        return label
    }()
    
    
   
    
    
    
    
    
    let productView = OrderInfoProductView ()
    
    
    let trackOrder : CustomButton = {
        let button  = CustomButton(title: "Track Order", hasBackground: true,  fontType: .small)
        
        return button
    }()
    
    let requestRefund : CustomButton = {
        let button  = CustomButton(title: "Refund", hasBackground: true,  fontType: .small)
        
        return button
    }()
    
    let totalPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    let totalPriceValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$59.90"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    
    
    // MARK: - Components
    // Here you add all components
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Order details"
        label.textAlignment = .center
        return label
    }()
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        setUpTableView()
        setupUI()
        
    }
    
    // MARK: - UI Setup
    
    private func setupUI(){
        view.addSubview(tableViewProducts)
        tableViewProducts.anchor(top:  self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: self.view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -20, width: nil, height: nil)
    }
//    private func setupUI() {
//        // Set up all UI elements here
//
//        let quantiyProductStack  = self.createProductStack(withNumberOfProducts: 4)
//
//
//        let widthButton = self.view.frame.width / 3
//        let heightbutton = 30
//        requestRefund.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
//        requestRefund.heightAnchor.constraint(equalToConstant: CGFloat(heightbutton)).isActive = true
//        trackOrder.widthAnchor.constraint(equalToConstant: widthButton).isActive = true
//        trackOrder.heightAnchor.constraint(equalToConstant: CGFloat(heightbutton)).isActive = true
//        let buttonStacks  = StackManager.createStackView(with: [requestRefund, trackOrder, ], axis: .horizontal, spacing: 10, distribution: .fillProportionally, alignment: .trailing)
//
//
//
//
//
//        let totalStack  = StackManager.createStackView(with: [totalPlaceholder, totalPriceValue], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .fill)
//
//
//        let productInfoStack  = StackManager.createStackView(with: [shopLabel, quantiyProductStack], axis: .vertical, spacing: 5, distribution: .fillProportionally, alignment: .leading)
//
//
//
//
//        view.addSubview(productInfoStack)
//        productInfoStack.anchor(top:  self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
//
//
//
//        view.addSubview(buttonStacks)
//        buttonStacks.anchor(top:  productInfoStack.bottomAnchor, left: nil, right: self.view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
//
//        view.addSubview(totalStack)
//        totalStack.anchor(top:  buttonStacks.bottomAnchor,  left: self.view.leadingAnchor , right:  self.view.trailingAnchor, bottom: nil, paddingTop: 15, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
//
//
//
//
//
//    }
//
//
    
    private func setUpTableView(){
        self.tableViewProducts.delegate = self
        self.tableViewProducts.dataSource = self
        self.tableViewProducts.register(OrderProductCell.self, forCellReuseIdentifier: productinfoCellIdentifier)
        self.tableViewProducts.register(OrderStatusCell.self, forCellReuseIdentifier: orderStatusCellIdentifer)
        self.tableViewProducts.register(OrderStatusPersonalization.self, forCellReuseIdentifier: orderPersonalizationCellIdentifier)
        self.tableViewProducts.register(OrderInfoCell.self, forCellReuseIdentifier: orderInfoCellIdentifier)
        
       
    }
    
    private func  configureUI(_ order : OrderItem){
        self.totalPriceValue.text =  "\(order.total)"
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
    func createProductStack(withNumberOfProducts numberOfProducts: Int) -> UIStackView {
        let stackProductsViews = StackManager.createStackView(with: [], axis: .vertical, spacing: 0, distribution: .fill, alignment: .fill)
        
        for _ in 0..<numberOfProducts {
            let productView = OrderInfoProductView()
            productView.translatesAutoresizingMaskIntoConstraints = false
            stackProductsViews.addArrangedSubview(productView)
        }
        
        return stackProductsViews
    }
    
    
    
}


extension OrderDetailsController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
              let cell = tableView.dequeueReusableCell(withIdentifier: orderStatusCellIdentifer, for: indexPath) as! OrderStatusCell
              // configure your cell if needed
                cell.status.text =  orderItem?.status.rawValue
                cell.message.text = orderItem?.status.descriptionBuyer
              return cell
          } else if indexPath.section == 1 {
              let cell = tableView.dequeueReusableCell(withIdentifier: productinfoCellIdentifier, for: indexPath) as! OrderProductCell
              cell.orderItem = orderItem
              // configure your cell if needed
              return cell
          }else if indexPath.section == 2 {
           let cell = tableView.dequeueReusableCell(withIdentifier: orderPersonalizationCellIdentifier, for: indexPath) as! OrderStatusPersonalization
           
           // configure your cell if needed
          if let personalizationText  = self.orderItem?.customizationOptions?.first{
              cell.personalization.text = "\(personalizationText )"
  
          }
           return cell
       }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: orderInfoCellIdentifier, for: indexPath) as! OrderInfoCell
            // configure your cell if needed
              cell.addressValue.text =  orderItem?.shippingDetails?.formattedAddress()
              cell.orderIDValue.text = orderItem?.orderId
              cell.orderDateValue.text = TimeManager.orderFormatterWithTime(orderItem?.createdAt ?? "" )
              
              
              
            return cell
        }
        return UITableViewCell()
              
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return  0.0
        }
        
        return 10.0 // Adjust this value to increase or decrease the space
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return  nil
        }

        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        return emptyView
    }

    
    
}
