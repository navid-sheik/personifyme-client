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
                let index = self.setSelectedScopeButton(matchingStatus: self.filterPassed ?? "Processing")
                print (index)
                if index >= 0 {
                    // Successfully set, handle additional logic if needed
                    self.handleSelectedScopeChange(selectedScope: index)
               
                } else {
                    // Status not found in scopeButtonTitles
                    self.handleSelectedScopeChange(selectedScope: 0)
                }

                self.tableViewOrders.reloadData()
            }
           
        }
    }
    var filteredOrderItems: [OrderItem] = []{
        didSet{
            
            DispatchQueue.main.async {
            
                if self.filteredOrderItems.isEmpty {
                    if let selectedScope = self.getSelectedScopeTitle(from: self.searchBar) {
                        self.tableViewOrders.setEmptyMessage("You have 0 orders with status \(selectedScope)")
                    } else {
                        self.tableViewOrders.setEmptyMessage("You have 0 orders with this status")
                    }
                    
                } else {
                    self.tableViewOrders.restore()
                }
                self.tableViewOrders.reloadData()
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
    
    let closeButton  : UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
   
        button.setTitleColor(DesignConstants.primaryColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    var filterPassed: String?
    
    init(filter : String?) {
        self.filterPassed = filter
        
        super.init(nibName: nil, bundle: nil)
        // Do your custom initialization here
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        navigationItem.largeTitleDisplayMode =  .never
        let closeButton = UIBarButtonItem(title: "Close", style: .plain,  target: self, action: #selector(closeButtonTapped))
        closeButton.tintColor = DesignConstants.primaryColor
        self.navigationItem.rightBarButtonItem = closeButton
        self.navigationItem.title =  "Order History"

//        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
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
//        searchBar.sizeToFit()
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(closeButton)
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: -10, paddingBottom: 0, width: nil, height: 100)
//
//
//
        
        tableViewOrders.anchor( top: searchBar.bottomAnchor, left: searchBar.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor,  paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
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
    @objc func closeButtonTapped(){
        self.dismiss(animated: true)
    }
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}



extension OrderBuyerController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Show the cancel button when the user begins editing
        searchBar.showsCancelButton = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // First, filter items based on the selected scope.
        handleSelectedScopeChange(selectedScope: searchBar.selectedScopeButtonIndex)
        
        // Next, filter those scoped items based on the search text.
        if !searchText.isEmpty {
            filteredOrderItems = filteredOrderItems.filter {
                $0.product.title.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Reload the table view to reflect the changes.
        tableViewOrders.reloadData()
    }


    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        // Call the function to filter items based on the selected scope
        handleSelectedScopeChange(selectedScope: searchBar.selectedScopeButtonIndex)
        tableViewOrders.reloadData()
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide the keyboard when the search button is clicked
        searchBar.resignFirstResponder()
    }

    // Allow editing to end
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    // Allow editing to begin
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
        controller.orderItem = filteredOrderItems[indexPath.section]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  =  BuyerOrderHeader()
        
       
        header.status.text  = filteredOrderItems[section].status.rawValue
        
        
        let order =  filteredOrderItems[section]
       
        if  let date = order.createdAt,   let estimatedDates = TimeManager.calculateEstimatedDates(for: order){
            
            let (maxShippingDate, maxDeliveryDate) = TimeManager.formatEstimatedDates(estimatedDates)
            
            if order.status == .Processing {
                
                header.date.text  =  maxShippingDate
            }else  if order.status == .Shipped{
                header.date.text =  maxDeliveryDate
            }else if order.status == .Delivered{
                header.date.text =  maxDeliveryDate
            }else {
                header.date.text =  ""
            }
            
           
        }
        
     
        return header
    }

    
    

}
extension  OrderBuyerController{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        handleSelectedScopeChange(selectedScope: selectedScope)
        tableViewOrders.reloadData()
    
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
    
    
}


