//
//  ManageListingsViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

class ManageListingController: UIViewController {
    
    var product: [Product] = []
    
    private let cellIdentifierSellerProductCell : String  = "cellIdentifierSellerProductCell"
    // MARK: - Components
    // Here you add all components
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
    
    let productCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
       
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = true
        cv.backgroundColor = .systemBackground
    
        return cv
    }()
    
    
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        setUpNavigationBar()
        setUpSearchBar()
        setupCollectionView()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellIdentifierSellerProductCell)
    }
    
    
    private func setUpSearchBar (){
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsBookmarkButton = true
        
        searchBar.setImage(UIImage(systemName: "slider.horizontal.3"), for: .bookmark, state: .normal)



    }
    
    
    private func setUpNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Listings"
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = .systemBackground
//        appearance.shadowColor = UIColor.clear
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//
        
    }
    
    private func setupUI() {
        
     
       
        
        view.addSubview(searchBar)
        searchBar.anchor( top: self.view.layoutMarginsGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 40)
        
        
     
        
        view.addSubview(filterButton)
        filterButton.anchor( top: searchBar.bottomAnchor, left: nil, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: 40, height: 40)
        
        
        
        view.addSubview(totalItemslabel)
        totalItemslabel.anchor( top: searchBar.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        
        totalItemslabel.centerYAnchor.constraint(equalTo: filterButton.centerYAnchor).isActive = true
        
        
        
        view.addSubview(productCollectionView)
        productCollectionView.anchor( top: filterButton.bottomAnchor, left:  view.leadingAnchor,  right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 5, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
       
        
        

        
        // Set up all UI elements here
//        view.addSubview(label)
//        
//        label.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 220)
//        
    }
    
    
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}

extension ManageListingController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier:cellIdentifierSellerProductCell, for: indexPath) as! ProductCell
        return cell
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: (view.frame.width - 6) / 3 , height:  (view.frame.width) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
    
}

extension ManageListingController : UISearchBarDelegate{
    
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
