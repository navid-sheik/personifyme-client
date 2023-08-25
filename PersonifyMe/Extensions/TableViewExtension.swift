//
//  TableViewExtension.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 23/08/2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        
        let emptyResultView  = NoResultView(message: message)
        emptyResultView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)

        
        
        self.backgroundView = emptyResultView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
