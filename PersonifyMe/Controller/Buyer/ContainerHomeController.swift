//
//  ContainerHomeControllr.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//



import Foundation


import UIKit

class ContainerHomeController: UIViewController {
    var homeController  :  HomeViewController!
    
    var centerController : UIViewController!
    var searchResultController : LikesViewController!
    var searchBar: UISearchBar?

    // MARK: - Components
    // Here you add all components

    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
//        setupUI()
    }
    
    private func setupSearchBar() {
           searchBar = UISearchBar()
           searchBar?.delegate = self
           searchBar?.sizeToFit()

           // Adding search bar to the navigation bar
           navigationItem.titleView = searchBar
       }
    
    
    private func loadMainView(){
        let homeController = HomeViewController()
        centerController =  homeController
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    // MARK: - UI Setup
    private func loadMenu(){
        if searchResultController == nil{
            searchResultController =  LikesViewController()
//            menuController.delegate = self
            //view.insertSubview(menuController.view, aboveSubview: centerController.view)
            view.insertSubview(searchResultController.view, at: 0)
            addChild(searchResultController)
            searchResultController.didMove(toParent: self)
        }
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}



extension ContainerHomeController : UISearchBarDelegate{
    
    
}
