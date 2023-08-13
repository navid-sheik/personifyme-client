//
//  CategoryMenuController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 12/08/2023.
//

import Foundation

import UIKit

class CategoryMenuContronller: UITableViewController {

    var categories = [Category]() // The items to show in the dropdown

    var selectedItem: ((Category) -> Void)? // The callback to handle the selection

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchCategories()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem?(categories[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func fetchCategories(){
        Service.shared.fecthAllCategories(expecting: ApiResponse<[Category]>.self) { result in
            switch result {
                
            case .success(let respose):
                guard let categories  =  respose.data else {return}
                self.categories = categories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
    
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
