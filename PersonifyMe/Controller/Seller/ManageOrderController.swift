//
//  ManageOrderControllers.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

class ManageOrderController: UIViewController {
    
    var orderItems : [OrderItem]=[]{
        didSet {
            // You may want to check the lastSelectedScope here and filter accordingly
            if lastSelectedScope == 0 { // Assuming 0 is for "Processing"
                filteredOrderItems = orderItems.filter { $0.status == .Processing }
            } else {
                filteredOrderItems = orderItems
            }
            // Since filteredOrderItems has its own didSet, you don't need to reload the tableView here
        }

    }
    
    var filteredOrderItems: [OrderItem] = []{
        didSet{
            
            
            DispatchQueue.main.async {
                self.totalItemslabel.text = "Total - \(self.filteredOrderItems.count) Orders"
                if self.filteredOrderItems.isEmpty {
                    if let selectedScope = self.getSelectedScopeTitle(from: self.searchBar) {
                        self.tableViewProducts.setEmptyMessage("You have 0 orders with status \(selectedScope)")
                    } else {
                        self.tableViewProducts.setEmptyMessage("You have 0 orders with this status")
                    }
                    
                } else {
                    self.tableViewProducts.restore()
                }
                self.tableViewProducts.reloadData()
            }
            
        }
    }

    
    
    
    func getSelectedScopeTitle(from searchBar: UISearchBar) -> String? {
        if let scopeButtonTitles = searchBar.scopeButtonTitles {
            let selectedIndex = searchBar.selectedScopeButtonIndex
            return scopeButtonTitles[selectedIndex]
        }
        return nil
    }
    
    
    
    
    var lastSearchText: String = ""
    var lastSelectedScope: Int = 0 // Assuming 0 is the default
    func isFiltering() -> Bool {
        return !lastSearchText.isEmpty || lastSelectedScope != 0
    }
    
    //MARK: - IDENTIFER
    let headerOrderIdentifier  : String = "headerOrderIdentifier"
    let tableCellOrderIdentifier  : String = "tableCellOrderIdentifier"
    
    // MARK: - Components
    // Here you add all components
    let tableViewProducts:  DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
     
        return tableView
    }()
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    let totalItemslabel : UILabel  =  {
        let label = UILabel()
        label.text  =  "Total - 0 Items"
        label.textColor  = DesignConstants.textColor
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    
    let filterButton : UIButton =  {
        let button  =  UIButton()
        button.setImage(UIImage(systemName: "slider.horizontal.3")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor =  DesignConstants.primaryColor
        return button
    }()
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Manage Orders"
        setUpSearchBar()
        setTableView()
        setupUI()
        fetchOrder()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(closeButton)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: nil, height: 100)
        view.addSubview(filterButton)
        filterButton.anchor( top: searchBar.bottomAnchor, left: nil, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: 40, height: 40)
        
        view.addSubview(totalItemslabel)
        totalItemslabel.anchor( top: searchBar.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        totalItemslabel.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor).isActive = true
        
        view.addSubview(tableViewProducts)
        tableViewProducts.anchor( top: filterButton.bottomAnchor, left:  view.leadingAnchor,  right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
       
        
        
        
        
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
        
//        searchBar.sizeToFit()
//        self.navigationItem.titleView = searchBar
      
    }
    
    
    func setSelectedScopeButton(matchingStatus status: String) -> Int {
        if let scopeButtonTitles = searchBar.scopeButtonTitles,
           let index = scopeButtonTitles.firstIndex(of: status) {
            searchBar.selectedScopeButtonIndex = index
            return index
        }
        return -1 // Return -1 or any other number to indicate that the status was not found
    }
    private func setTableView(){
        tableViewProducts.dataSource = self
        tableViewProducts.delegate = self
        tableViewProducts.register(ManageOrderCell.self, forCellReuseIdentifier: tableCellOrderIdentifier)
        
        
    }
    private func setUpNavigationBar(){
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Listings"
//
        
    }
    
    private func fetchOrder(){
        Service.shared.getOrderFromSeller(expecting: ApiResponse<[OrderItem]>.self, completion: { [weak self ] result  in
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

extension ManageOrderController  : UISearchBarDelegate {
    
  
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
    }

    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        lastSearchText = searchText
        updateFilteredItems()
       tableViewProducts.reloadData()
       print(searchText)
//        if searchText.isEmpty {
//            filteredOrderItems = orderItems
//        } else {
//            filteredOrderItems = orderItems.filter { orderItem in
//                return orderItem.product.title.lowercased().contains(searchText.lowercased()) ||
//                       (orderItem.shippingDetails?.name ?? "").lowercased().contains(searchText.lowercased())
//            }
//        }
//        tableViewProducts.reloadData()
//        print(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        lastSearchText = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        updateFilteredItems()
        tableViewProducts.reloadData()
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
extension ManageOrderController : UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredOrderItems.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellOrderIdentifier, for: indexPath) as! ManageOrderCell
       
        cell.orderItem =  filteredOrderItems[indexPath.section]
        cell.delegate = self
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  =  ManagerOrderHeader()
        let  orderItem = filteredOrderItems[section] // Assume this is an OrderItem object
        let estimatedDates = TimeManager.calculateEstimatedDates(for: orderItem)
        if let estimatedDates = estimatedDates {
            if orderItem.status == .Processing{
                let stringDateFormatted =  TimeManager.daysUntilOrderItem(estimatedDates.maxShippingDate)
                if stringDateFormatted == "Today" ||  stringDateFormatted == "Tomorrow"{
                    header.toBeShipped.text = "To Be Shipped \(stringDateFormatted) - Free Shipping"
                }else {
                    header.toBeShipped.text = "To Be Shipped in  \(stringDateFormatted) - Free Shipping"
                }
                
              
                
            }else if orderItem.status == .Shipped{
                let stringDateFormatted =  TimeManager.daysUntilOrderItem(estimatedDates.maxDeliveryDate)

                if stringDateFormatted == "Today" ||  stringDateFormatted == "Tomorrow"{
                    header.toBeShipped.text = "Estimate Delivery  \(stringDateFormatted) - Free Shipping"
                }else {
                    header.toBeShipped.text = "Estimate Delivery in \(stringDateFormatted) - Free Shipping"
                }
                
                
            }else if orderItem.status == .Delivered{
                header.toBeShipped.text = "Delivered"
            }
            
            
          
        }
       
       
        return header
    }
    
    
    

}



extension ManageOrderController: ManageOrderCellDelegate{
    func showTrackingpage(for cell: ManageOrderCell) {
        let vc = AddTrackingController()
        vc.delegate = self
        
        guard let indexPath = tableViewProducts.indexPath(for: cell) else {
            print("IndexPath not found for cell")
            return
        }
        
        // If filtering is active, use `filteredOrderItems`; otherwise use `orderItems`
        let currentOrderItem =  filteredOrderItems[indexPath.section] 
        
        print(currentOrderItem)  // Debugging purpose
        vc.order = currentOrderItem
        
        vc.modalPresentationStyle = .overCurrentContext
        self.definesPresentationContext = true
        self.present(vc, animated: true, completion: nil)
    }
   
    
    
}

extension ManageOrderController: AddTrackingControllerDelegate{
    func updateValue(courierName: String, trackingNumber: String, order: OrderItem?, indexPath: IndexPath?) {
        print("Update table now")
        guard let updatedOrder = order, let orderId = order?.orderId else { return }

        // Update item in orderItems based on orderId
        if let indexInOrderItems = orderItems.firstIndex(where: { $0.orderId == orderId }) {
            orderItems[indexInOrderItems] = updatedOrder
        }
        
        // Update item in filteredOrderItems based on orderId
        if let indexInFilteredOrderItems = filteredOrderItems.firstIndex(where: { $0.orderId == orderId }) {
            filteredOrderItems[indexInFilteredOrderItems] = updatedOrder
            // Reload the specific row in the table view
            let indexPathToReload = IndexPath(row: indexInFilteredOrderItems, section: 0)
            tableViewProducts.reloadRows(at: [indexPathToReload], with: .automatic)
        }
    }
    
   
    
    
}


extension  ManageOrderController{
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        lastSelectedScope = selectedScope
        updateFilteredItems()
          tableViewProducts.reloadData()
//        handleSelectedScopeChange(selectedScope: selectedScope)
//        tableViewProducts.reloadData()
    
    }

    
    func handleSelectedScopeChange(selectedScope: Int) {
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
     
    }
    
    func updateFilteredItems() {
        let scopeCondition: (OrderItem) -> Bool
        switch lastSelectedScope {
        case 0:
            scopeCondition = { $0.status == .Processing }
        case 1:
            scopeCondition = { $0.status == .Shipped }
            
        case 2:
            scopeCondition = { $0.status == .Delivered }
        default:
            scopeCondition = { $0.status == .Refunded || $0.status == .Cancelled || $0.status == .Returned }
        }

        if lastSearchText.isEmpty {
            filteredOrderItems = orderItems.filter(scopeCondition)
        } else {
            filteredOrderItems = orderItems.filter { orderItem in
                return scopeCondition(orderItem) && (
                    orderItem.product.title.lowercased().contains(lastSearchText.lowercased()) ||
                    (orderItem.shippingDetails?.name ?? "").lowercased().contains(lastSearchText.lowercased())
                )
            }
        }
    }
    
}


