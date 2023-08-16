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
    
    var ordersItems : [OrderItem] = []{
        didSet{
            print(ordersItems)
            DispatchQueue.main.async {
                self.tableViewProducts.reloadData()
            }
        }
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
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
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        return button
    }()
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        navigationController?.navigationBar.isHidden = true
        setUpSearchBar()
        setTableView()
        setupUI()
        fetchOrder()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(searchBar)
        searchBar.anchor( top: self.view.layoutMarginsGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 40)
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
//        searchBar.showsBookmarkButton = true
        
        searchBar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)



    }
    
    private func setTableView(){
        tableViewProducts.dataSource = self
        tableViewProducts.delegate = self
        tableViewProducts.register(ManageOrderCell.self, forCellReuseIdentifier: tableCellOrderIdentifier)
        
        
    }
    private func setUpNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Listings"
        
        
    }
    
    private func fetchOrder(){
        Service.shared.getOrderFromSeller(expecting: ApiResponse<[OrderItem]>.self, completion: { [weak self ] result  in
            guard let self =  self else {return}
            switch result {
                
            case .success(let response):
                guard let orderItems = response.data else {return}
                self.ordersItems =  orderItems
                
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

extension ManageOrderController : UISearchBarDelegate {
    
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
extension ManageOrderController : UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersItems.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellOrderIdentifier, for: indexPath) as! ManageOrderCell
       
        cell.orderItem =  ordersItems[indexPath.section]
        cell.delegate = self
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header  =  ManagerOrderHeader()
      
        return header
    }
    
    
    

}



extension ManageOrderController: ManageOrderCellDelegate{
    func showTrackingpage(for cell: ManageOrderCell) {
        let vc = AddTrackingController()
        vc.delegate = self
        
        let indexPath = tableViewProducts.indexPath(for: cell)
        vc.order = ordersItems[indexPath!.section]
        vc.modalPresentationStyle = .overCurrentContext
        self.definesPresentationContext = true //*** adding this line should solve your issue ***
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
   
    
    
}

extension ManageOrderController: AddTrackingControllerDelegate{
    func updateValue(courierName: String, trackingNumber: String, order: OrderItem?, indexPath: IndexPath?) {
        print("Update table now ")

            guard let indexPath = indexPath, let order = order else { return }

            
            self.ordersItems[indexPath.row] = order
            self.tableViewProducts.reloadRows(at: [indexPath], with: .automatic)
        
        
       

        
        
        
        
//        ordersItems[indexPath?.row] = order!
//        tableViewProducts.reloadRows(at: [indexPath!], with: .automatic)
//
    }
    
   
    
    
}

