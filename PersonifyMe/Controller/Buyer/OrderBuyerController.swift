//
//  OrderBuyerController.swift
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

class OrderBuyerController: UIViewController {
    
    var orderItems : [OrderItem]=[]{
        didSet{
            filteredOrderItems = orderItems
            DispatchQueue.main.async {
                self.tableViewOrders.reloadData()
            }
           
        }
    }
    var filteredOrderItems: [OrderItem] = []
    
    
    //MARK: - Identifier
    
    
    private let tableCellOrderIdentifier : String = "tableCellOrderIdentifier"
    
    private let tableCellOrderIdentifierHeader : String = "tableCellOrderIdentifierHeader"
    
    
    // MARK: - Components
    // Here you add all components
    
    let tableViewOrders:  DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
      
        
     
        return tableView
    }()
    
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Something"
        return label
    }()
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationItem.title = "Orders"
        setUpSearchBar()
        setTableView()
        setupUI()
        fetchOrder()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(tableViewOrders)
        
        tableViewOrders.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor,  paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    
    private func setUpSearchBar (){
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsBookmarkButton = false
        
        searchBar.showsScopeBar = true
//        searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.1)
        searchBar.scopeButtonTitles = ["Processing", "Shipped",  "Delivered",  "Refunded"]

        // To change UISegmentedControl color only when appeared in UISearchBar
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .red
        
        self.navigationItem.titleView = searchBar


    }
    
    private func setTableView(){
        tableViewOrders.dataSource = self
        tableViewOrders.delegate = self
        tableViewOrders.register(OrderBuyerSell.self, forCellReuseIdentifier: tableCellOrderIdentifier)
        tableViewOrders.register(BuyerOrderHeader.self, forHeaderFooterViewReuseIdentifier: tableCellOrderIdentifierHeader)
        
        
    }
    
    private func fetchOrder(){
        Service.shared.getOrdersForBuyers(expecting: ApiResponse<[OrderItem]>.self, completion: { [weak self ] result  in
            guard let self =  self else {return}
            switch result {
                
            case .success(let response):
                guard let orderItems = response.data else {return}
                self.orderItems =  orderItems
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}



extension OrderBuyerController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredOrderItems = orderItems
        } else {
            filteredOrderItems = orderItems.filter {
                $0.product.title.lowercased().contains(searchText.lowercased())
            }
        }
        tableViewOrders.reloadData()
        print(searchText)
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
        filteredOrderItems = orderItems
        tableViewOrders.reloadData()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
     
    }

  
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
extension OrderBuyerController : UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  filteredOrderItems.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellOrderIdentifier, for: indexPath) as! OrderBuyerSell
        cell.orderItem =  filteredOrderItems[indexPath.section]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = OrderDetailsController()
        controller.orderItem = orderItems[indexPath.section]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  =  BuyerOrderHeader()
        
       
        header.status.text  = orderItems[section].status.rawValue
        
        if  let date = orderItems[section].createdAt{
            header.date.text =  TimeManager.orderDateFormatter( date)
           
        }
        
     
        return header
    }

    
    

}
extension  OrderBuyerController{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            print("Processing selected")
            filteredOrderItems = orderItems.filter { $0.status == .Processing }
        case 1:
            print("Shipped selected")
            filteredOrderItems = orderItems.filter { $0.status == .Shipped }
        case 2:
            print("Delivered selected")
            filteredOrderItems = orderItems.filter { $0.status == .Delivered }
        case 3:
            print("Refunded or Cancelled or Returned selected")
            filteredOrderItems = orderItems.filter { $0.status == .Refunded || $0.status == .Cancelled || $0.status == .Returned }
        default:
            filteredOrderItems = orderItems
        }
        tableViewOrders.reloadData()
    }

    
    
}


