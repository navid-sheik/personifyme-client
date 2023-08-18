//
//  SearchesQueryController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 18/08/2023.
//

import Foundation


import UIKit

protocol  SearchesQueryControllerDelegate :class{
    
    func didSelectedQuery(query : String)

}

class SearchesQueryController: UIViewController {
    
    weak var delegate : SearchesQueryControllerDelegate?
    
    var searchesFilterded : [SearchQuery] = []{
        didSet{
            
            DispatchQueue.main.async {
                self.tableViewProducts.reloadData()
            }
         
        }
    }
    
    var popularSearches :  [SearchQuery] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableViewProducts.reloadData()
            }
        }
    }
    
    var isSearching: Bool = false
    
    private let identifierCellIdentifeir : String = "identifierCellIdentifeir"
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
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        setupUI()
        setUpTableView()
        fetchPopularSearches()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        self.view.addSubview(tableViewProducts)

        tableViewProducts.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: self.view.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: -10, width: nil, height: nil)
       

        
    }
    
    
    func setUpTableView(){
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
     
        tableViewProducts.register(UITableViewCell.self, forCellReuseIdentifier: identifierCellIdentifeir)

    }
    
    
    func fetchPopularSearches (){
        print("Print popualar searches ")
        Service.shared.getPopularSearches(expecting: ApiResponse<[SearchQuery]>.self) { [weak self]  result in
            guard let self  = self else {return}
            switch result {
                
            case .success(let response):
                guard let searchqueries  = response.data else {return}
                self.popularSearches = searchqueries
            case .failure(_):
                print("Error fetching")
            }
        }
        
    }
    
    
    func fecthSearchResults(for query : String){
        print("Search requeslt")
        Service.shared.getSearchFiltered(with: query, expecting: ApiResponse<[SearchQuery]>.self) { [weak self]  result in
            guard let self  = self else {return}
            switch result {
                
            case .success(let response):
                guard let searchqueries  = response.data else {return}
                self.searchesFilterded = searchqueries
            case .failure(_):
                print("Error fetching")
            }
        }
    }
//
//
//    override func viewWillAppear (_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.fetchPopularSearches()
//    }
    func updateContent(with searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            self.tableViewProducts.reloadData()
        } else {
            isSearching = true
            // Fetch the searches that match the query (you probably want a network request here)
            fecthSearchResults(for: searchText)
        }
        
        
    }

    
 
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}

extension SearchesQueryController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
               return searchesFilterded.isEmpty ? 1 : searchesFilterded.count
           } else {
               return popularSearches.isEmpty ? 1 : popularSearches.count
           }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCellIdentifeir, for: indexPath)
        
        if isSearching {
            if searchesFilterded.isEmpty {
                cell.textLabel?.text = "No suggestion"
            } else {
                cell.textLabel?.text = searchesFilterded[indexPath.row].query
            }
        } else {
            if popularSearches.isEmpty {
                cell.textLabel?.text = "No suggestion"
            } else {
                cell.textLabel?.text = popularSearches[indexPath.row].query
            }
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching {
            if !searchesFilterded.isEmpty {
                let query = searchesFilterded[indexPath.row].query
                self.delegate?.didSelectedQuery(query: query)
               
            }
        } else {
            if !popularSearches.isEmpty {
                let query = popularSearches[indexPath.row].query
                self.delegate?.didSelectedQuery(query: query)
              
            }
        }
    
    }
    
    
    
}

