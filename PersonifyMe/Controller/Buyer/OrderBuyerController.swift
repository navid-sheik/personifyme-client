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
 
        // Update the search results
        
        print(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear the search results and remove the search results controller
        searchBar.text = ""
        searchBar.resignFirstResponder()
//        searchBar.showsCancelButton = false
        self.searchBar.showsCancelButton = false

    
        
   
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
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellOrderIdentifier, for: indexPath) as! OrderBuyerSell
       

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = OrderDetailsController()
        
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  =  BuyerOrderHeader()
       
        return header
    }

    
    

}


