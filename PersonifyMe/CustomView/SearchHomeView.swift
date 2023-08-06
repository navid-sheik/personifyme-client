//
//  SearchBarCollectionReusableView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import Foundation

import UIKit




class SearchHomeView: UIView {
    lazy var  searchBar = UISearchBar()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
          return UIView.layoutFittingExpandedSize
      }
}


