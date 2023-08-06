//
//  CategoryViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit


class CategoryViewController: UITableViewController{
    
    //MARK: Identifier
    
    private let categoryCell =  "categoryCell"
    
    
    //MARK: Properties
    
    var categories: [Category] = []

    
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title =  "Categories"
        tableView.backgroundColor = .systemBackground
        tableView.register(CategoryLabelCell.self, forCellReuseIdentifier:  categoryCell)
        tableView.estimatedRowHeight =  40
        tableView.rowHeight = UITableView.automaticDimension
        self.fetchCategories()
    }
    
    private func fetchCategories(){
        Service.shared.fecthAllCategories(expecting: ApiResponse<[Category]>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
                
                
            case .success(let response):
                guard let categories = response.data else {
                    print("Cannot get the categories ")
                    return
                    
                }
                self.categories =  categories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
}

extension CategoryViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows in section
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCell, for: indexPath) as! CategoryLabelCell
        
        cell.categoryLabel.text =  categories[indexPath.row].name
        
    
 
        return cell
    }
    
// In case you want to handle tap events on cells
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        print("Selected Category: \(selectedCategory.name)")
    }
    
    

 
 




}
