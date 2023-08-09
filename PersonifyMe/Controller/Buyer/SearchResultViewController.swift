//
//  SearchResultViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//
//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

class SearchResultViewController: UIViewController {
    
    
    
    
    
    private let cellIdentifierProductSearch : String  = "cellIdentifierProductSearch"
    var textSearchBar : String
    // MARK: - Components
    // Here you add all components
    
    let progressBar =  ReusableProgressBar()
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Resutl  "
        label.textAlignment  = .center
        return label
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
    
    
    let filterButton : UIButton =  {
        let button  =  UIButton()
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        return button
    }()
    
    let totalItemslabel : UILabel  =  {
        let label = UILabel()
        label.text  =  "Total - 0 Items"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    private var  progress = Progress(totalUnitCount: 100)
    
    
    let searchBar = UISearchBar()
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    init(textSearchBar: String) {
        self.textSearchBar = textSearchBar
        super.init(nibName: nil, bundle: nil)

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = textSearchBar
        self.view.backgroundColor  = .systemBackground
       
        progressBar.setProgress(progress)
        setUpNavigationBar()
        setUpSearch()
        setupCollectionView()
        setupUI()
//        simulateDownload()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(progressBar)
        progressBar.anchor( top: self.view.layoutMarginsGuide.topAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: 20)
        
        view.addSubview(filterButton)
        filterButton.anchor( top: self.progressBar.bottomAnchor, left: nil, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: 40, height: 40)
        
        
        
        view.addSubview(totalItemslabel)
        totalItemslabel.anchor( top: self.progressBar.bottomAnchor, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 5,paddingRight: -5, paddingBottom: 0, width: nil, height: nil)
        
        
        
        view.addSubview(productCollectionView)
        productCollectionView.anchor( top: filterButton.bottomAnchor, left:  view.leadingAnchor,  right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 5, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
       
        
    }
    
    private func setupCollectionView() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellIdentifierProductSearch)
    }
    
    
    private func setUpNavigationBar  (){
        navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = UIColor.clear
//        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
//                                          .foregroundColor: UIColor.white]
//        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    private func setUpSearch(){
        searchBar.placeholder = "Search"
      navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.searchTextField.clearButtonMode = .whileEditing
        let customBackButton = UIBarButtonItem(image: UIImage(systemName:  "arrow.backward"), style: .plain, target: self, action: #selector(handleBackButton))
        self.navigationItem.leftBarButtonItem = customBackButton
    }
    func simulateDownload() {
            DispatchQueue.global().async {
                for _ in 1...100 {
                    sleep(1)
                    self.progress.completedUnitCount += 1
                }
            }
        }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    @objc func handleBackButton(){
        if searchBar.isFirstResponder{
            searchBar.resignFirstResponder()
        }
        else {
            if self.navigationController?.previousViewController is HomeViewController {
                self.searchBar.text = ""
                self.navigationController?.popViewController(animated: true)
            } else {
               
                self.navigationController?.popViewController(animated: false)
            }
            
        }
       
      
    
    }
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    
    func fetchQueryResult(){
        Service.shared
    }
}


extension SearchResultViewController :  UISearchBarDelegate{
    
   func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
//       presentSearch()
   }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
      
        let controller = SearchResultViewController(textSearchBar: searchBar.text ?? "")
        
   
        self.navigationController?.pushViewController(controller, animated: false)
    }

}

extension SearchResultViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierProductSearch, for: indexPath) as! ProductCell
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

