//
//  DropdownMenuController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 01/08/2023.
//

import Foundation
import UIKit

class DropdownMenuController: UITableViewController {
    
    var items = [String]() // The items to show in the dropdown
    
    var selectedItem: ((String) -> Void)? // The callback to handle the selection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem?(items[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
