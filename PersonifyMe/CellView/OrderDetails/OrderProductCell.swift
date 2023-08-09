//
//  OrderBuyerCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 07/08/2023.
//

import Foundation
import UIKit



class OrderProductCell : UITableViewCell{
    
    
    //MARK:Identifier
    
    let singleOrderProductIdentifier : String = "singleOrderProductIdentifier"
    
    

    
    
    let shopLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My Shop"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.numberOfLines = 1
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
    
    let totalPriceValue : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$59.90"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let trackOrder : CustomButton = {
        let button  = CustomButton(title: "Track Order", hasBackground: true,  fontType: .small)
        
        return button
    }()
    
    let requestRefund : CustomButton = {
        let button  = CustomButton(title: "Refund", hasBackground: true,  fontType: .small)
        
        return button
    }()
    
    
    
    let tableViewProducts : DynamicTableView = {
        let table = DynamicTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none
    
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 95
        
      
    
        
      
        return table
    }()
    
    
    
    
    
    
    let dummyView : UIView = {
        let custom_view  =  UIView()
        custom_view.translatesAutoresizingMaskIntoConstraints = false
        return custom_view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor =  UIColor.init(red: 0.949, green: 0.949, blue: 0.97, alpha: 1.0)
        setUpTableView()
        setupUI()
    }
    
    func setUpTableView(){
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
     
        tableViewProducts.register(SingleOrderProduct.self, forCellReuseIdentifier: singleOrderProductIdentifier)
        
    }
    
    func setupUI(){
        
        addSubview(shopLabel)
        shopLabel.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        addSubview(tableViewProducts)

        tableViewProducts.anchor(top: shopLabel.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
       


        

        
        
        addSubview(trackOrder)
        
        let widthButton = self.frame.width / 3
        trackOrder.anchor(top:  tableViewProducts.bottomAnchor, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: widthButton, height: 30)
        
        addSubview(requestRefund)
        
        requestRefund.anchor(top:  nil, left: nil , right: self.trackOrder.leadingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: widthButton, height: 30)
        
        requestRefund.centerYAnchor.constraint(equalTo: trackOrder.centerYAnchor).isActive = true
        
        
        let totalStack  = StackManager.createStackView(with: [totalPlaceholder, totalPriceValue], axis: .horizontal, spacing: 10, distribution: .fill, alignment: .fill)
        
        
        addSubview(totalStack)

        
        totalStack.anchor(top: trackOrder.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 30)
//
//        totalStack.centerYAnchor.constraint(equalTo: trackOrder.centerYAnchor).isActive = true
        
        
        
        
        
//
//
//
//
//        addSubview(dummyView)
//        dummyView.anchor(top: trackOrder.bottomAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension OrderProductCell : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: singleOrderProductIdentifier) as! SingleOrderProduct
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
   
    

    
    
    
}
