//
//  HomeController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var animatedBarButtonItem: UIBarButtonItem?
    
    //MARK: CELL Identifiers
    var bannerIdentifierCell  : String =  "bannerIdentifierCell"
    private let  cellIdentifierMain : String =  "cellIdentifierMain"
    
    private let cellNewArrivalsIdentifier : String =  "cellNewArrivalsIdentifier"
    private let tagCellIdenfier : String  =  "tagCellIdenfier"
    
    //MARK: ARRAYS
    
    var allproducts  =  [Product]()
    
    
    
    
    //MARK: HEADER IDENTIFIER
    static let headerJustLabel  =  "headerId"
    private  let newArrivalsHeaderId  =  "newArrivalsHeaderId"
    private  let featureProductHeaderId  =  "featureProductHeaderId"

    
    private let popularHeaderId = "popularHeaderId"
    private let categoryHeaderId = "categoryHeaderId"
    private let recommendedHeaderId = "recommendedHeaderId"
    private let tagPopularSearchHeaderId = "tagPopularSearchHeaderId"
    
    
    //MARK: TIMER
    private var timer : Timer?
    private var counter  = 0
    
    
    //MARK: Components
    private let spinner  =  UIActivityIndicatorView(style: .large)
    let collectionView : UICollectionView = {
        let cv  =  UICollectionView(frame: .zero, collectionViewLayout: HomeViewController.createLayout())
        cv.backgroundColor  = .white
        return cv
    }()
    
    var searchController: UISearchController!
    
    
    var  searchBarHome :  SearchHomeView!

    
    
    
    let searchBar = UISearchBar()
    var searchResultsController: LikesViewController!
  

   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout  = []
        self.view.backgroundColor =  .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        searchBar.placeholder = "Search"
        searchBar.searchTextField.clearButtonMode = .whileEditing
          navigationItem.titleView = searchBar
        searchBar.searchTextField.clearButtonMode = .whileEditing
       
          searchBar.delegate = self
       

          // Set up the container view
        
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//        self.navigationItem.largeTitleDisplayMode = .never
////
////        navigationItem.title = nil
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.layoutIfNeeded()
////
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
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.isTranslucent = true
//        navigationController?.navigationBar.isHidden = true

        
      
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(didTapLogout))
//
        
//        self.setUpSearchController()
     
        self.setUpCollectionView()

       
       
//        view.addSubview(searchBarHome)
        
//
//        searchBarHome.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: nil, height: 50)
        view.addSubview(collectionView)
        collectionView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: -20, width: nil, height: nil)
        
       
        feathAllDataNeeded()
        
        
        
       
       
        
        //        DispatchQueue.main.async {
        //            self.timer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        //        }
        // Do any additional setup after loading the view.
    }
    
//    func setUpSearchController (){
//        // create the search controller
//            searchController = UISearchController(searchResultsController: LikesViewController())
//            searchBarHome =  SearchHomeView()
//
//            searchController.searchResultsUpdater = self
//            searchController.obscuresBackgroundDuringPresentation = false
//            searchController.searchBar.placeholder = "Search"
//            searchController.searchBar.delegate = self
////            searchBarHome.searchBar = searchController.searchBar
//
////            navigationItem.searchController = searchController
//        let segmentedControl = UISegmentedControl(items: ["Filter 1", "Filter 2", "Filter 3", "Filter 4"])
////              segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
//              searchController.searchBar.scopeButtonTitles = ["Filter 1", "Filter 2",  "Filter 3", "Filter 4"]
//              searchController.searchBar.showsScopeBar = true
//
//
//
//            self.navigationItem.searchController = searchController
//            self.definesPresentationContext = true
//            self.navigationItem.hidesSearchBarWhenScrolling = false
//        // Create a segmented control
//
//
//
//
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    
    
    
   
   
    func feathAllDataNeeded(){
        
        let group = DispatchGroup()
        
        
         
        group.enter()
        fetchAllProducts()
        
        group.leave()
        
        
        group.notify(queue: DispatchQueue.global()) {
          
            DispatchQueue.main.async() {
                self.collectionView.refreshControl?.endRefreshing()
            }
            
        }
    }
    
    
    func fetchAllProducts (){
        Service.shared.fetchAllProducts(expecting: ApiResponse<[Product]>.self) { [weak self] result in
            
            guard let self =  self else {return}
            switch result{
                
            case .success(let response):
               
                guard let products  = response.data else {return}
                self.allproducts = products
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
               
            case .failure(_):
                return
            }
        }
    }
    
    
    
    @objc private func didTapLogout(){
        Service.shared.logout(expecting: ApiResponse<String>.self) { [weak self] result in
            switch result{
            case .success(_):
                print("Success in logout")
                AuthManager.clearUserDefaults()
                AlertManager.showLogoutAlert(on: self!)
            case .failure(let error):
                ErrorManager.handleServiceError(error, on: self)
            }
            
        }
    }
    
    
    let navigationViewBar : CustomHomeMenu =  {
        let view  = CustomHomeMenu()
        return view
    }()

    
    private func setUpCollectionView(){

        
        collectionView.backgroundColor =  .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifierMain)
        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeViewController.headerJustLabel, withReuseIdentifier: newArrivalsHeaderId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeViewController.headerJustLabel, withReuseIdentifier: featureProductHeaderId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeViewController.headerJustLabel, withReuseIdentifier: recommendedHeaderId)
        collectionView.register(Header.self, forSupplementaryViewOfKind: HomeViewController.headerJustLabel, withReuseIdentifier: tagPopularSearchHeaderId)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerIdentifierCell)
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellNewArrivalsIdentifier)
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: tagCellIdenfier)
        collectionView.delegate = self
        collectionView.dataSource = self
      
//        collectionView.refreshControl = UIRefreshControl()
//        collectionView.refreshControl?.addTarget(self, action: #selector(refreshingData), for: .valueChanged)
    }
    
    
    
    
    
    //MARK: -COMPOSITIONAL LAYOUT
    static func createLayout() -> UICollectionViewCompositionalLayout{
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group  =  NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), subitems: [item])
                
                let  section  = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets.bottom = 25
                return section
                
                
            }else if sectionNumber == 1{
                
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 8
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.40), heightDimension: .fractionalWidth(0.40)), subitems: [item])
                group.contentInsets.trailing =  8
                
                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .continuousGroupLeadingBoundary
                
                section.contentInsets.leading = 8
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HomeViewController.headerJustLabel, alignment: .topLeading)]
                
                section.contentInsets.bottom = 25
                return section
                
            }
            
            else if sectionNumber == 2{
               
        

                
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 8
       
//                item.contentInsets.leading = 8
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)), subitems: [item])
                group.contentInsets.trailing = 8

                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .continuousGroupLeadingBoundary
   
                section.contentInsets.leading = 8
//                section.contentInsets.trailing = 8
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HomeViewController.headerJustLabel, alignment: .topLeading)]
                
                section.contentInsets.bottom = 25
                return section
                
            }
            
            else if sectionNumber == 3{
                
                let  item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalWidth(0.50)))
                item.contentInsets.trailing = 8
                item.contentInsets.bottom = 16
                
                let group =  NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section  =  NSCollectionLayoutSection(group: group)
                
                section.contentInsets.leading =  8
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HomeViewController.headerJustLabel, alignment: .topLeading)]
                return section
            }
            else if sectionNumber == 4{
                
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), subitems: [item])
//                group.contentInsets.trailing =  16
                
                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .continuous
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HomeViewController.headerJustLabel, alignment: .topLeading)]
                section.contentInsets.leading =  8
                section.contentInsets.bottom = 25
                
                return section
            }
            
            
            
            
            else {
                let item =  NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 16
                
                let group  = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                group.contentInsets.trailing =  16
                
                let section  = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior =  .paging
                
                section.contentInsets.leading = 16
                section.boundarySupplementaryItems =  [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: "Some id", alignment: .topLeading)]
                
                section.contentInsets.bottom = 25
                return section
            }
            
        }
        
    }

        
        
      
        
        
        
        
        
        
        //MARK: HELPER FUNCTIONS
        
        //    func startTimer()
        //    {
        //      if timer == nil {
        //        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        //      }
        //    }
        //
        //    func stopTimer()
        //    {
        //      if timer != nil {
        //        timer!.invalidate()
        //        timer = nil
        //      }
        //    }
        //
        //
        //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //        let  offset =  targetContentOffset.pointee.y
        //        if offset < 200{
        //            startTimer()
        //        }else {
        //            stopTimer()
        //        }
        //    }
    
    @objc private func refreshingData (){
        feathAllDataNeeded()
    }
    
    @objc func handleBackButton(){
        self.dismissSearch()
        if self.searchBar.isFirstResponder {
            self.searchBar.resignFirstResponder()
            self.searchBar.text = ""
            
        }
    }
        
        
}


extension HomeViewController : UISearchBarDelegate{
    
    
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if animatedBarButtonItem == nil {
               animatedBarButtonItem =   UIBarButtonItem(image: UIImage(systemName:  "arrow.backward"), style: .plain, target: self, action: #selector(handleBackButton))
           }
           
           // Animate the appearance
           UIView.animate(withDuration: 0.3, animations: {
               self.navigationItem.setLeftBarButton(self.animatedBarButtonItem, animated: true)
               self.navigationController?.navigationBar.layoutIfNeeded()
           })
        
      
      
        presentSearch()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // When the search bar is not active, remove the bar button item
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.setLeftBarButton(nil, animated: true)
            self.navigationController?.navigationBar.layoutIfNeeded()
        })
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 
        // Update the search results
        performSearch(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear the search results and remove the search results controller
        searchBar.text = ""
        searchBar.resignFirstResponder()
//        searchBar.showsCancelButton = false
        dismissSearch()
    
        
   
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
      
        let controller = SearchResultViewController(textSearchBar: searchBar.text ?? "")
        self.searchResultsController.view.frame.origin.x = self.searchResultsController.view.frame.width
        self.searchBar.text = ""
   
        self.navigationController?.pushViewController(controller, animated: false )
        
    }

    // Perform the search and update the searchResultsController with the results
    func performSearch(with text: String) {
        print("Text")
        // Also, make sure to update the UI in the searchResultsController to reflect the new results
    }

    
    
    // Present the search view controller.
    func presentSearch() {

            if searchResultsController == nil{
                searchResultsController =  LikesViewController()
    //            menuController.delegate = self
                //view.insertSubview(menuController.view, aboveSubview: centerController.view)
                searchResultsController.view.frame.origin.x = self.searchResultsController.view.frame.width
                view.insertSubview(searchResultsController.view, at: 1)
                addChild(searchResultsController)
                
                searchResultsController.didMove(toParent: self)
                UIView.animate(withDuration: 0.3) {
                        self.searchResultsController.view.frame.origin.x = 0
                    }
            }else{
                // Assuming searchResultsController view's frame is already offscreen, e.g., to the right.
                // This will depend on your specific layout, modify as needed.
  
                UIView.animate(withDuration: 0.3, animations: {
                    self.searchResultsController.view.frame.origin.x = 0
                    
                  })
                
                
            }
        
        
        
    }

    // Dismiss the search view controller.
    func dismissSearch() {
        // Animate the searchResultsController's view back offscreen
        UIView.animate(withDuration: 0.3, animations: {
            self.searchResultsController.view.frame.origin.x =  self.searchResultsController.view.frame.width

        })
    }
    
}

extension HomeViewController :  UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1{
            return allproducts.count
        }
        else if section == 2{
            return 1
        }
        else if section == 3{
            return 6
        }
        else if section == 3{
            return 10
        }
        return 10

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: bannerIdentifierCell, for: indexPath) as! BannerCell
            cell.mainImage.image =  UIImage(named: "placeholder")
            return cell
        }else if   indexPath.section == 1{
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: cellNewArrivalsIdentifier, for: indexPath) as! ProductCell
            //        cell.tagName.text =  featuredIngredients[indexPath.row].strIngredient
            
            
     
            cell.mainImage.loadImageUrlString(urlString: allproducts[indexPath.row].images[0])
            return cell
        }
        
        else  if   indexPath.section == 2  {
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: cellNewArrivalsIdentifier, for: indexPath) as! ProductCell
            //        cell.tagName.text =  featuredIngredients[indexPath.row].strIngredient
            return cell
        }else if indexPath.section == 3{
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: cellNewArrivalsIdentifier, for: indexPath) as! ProductCell
            //        cell.tagName.text =  featuredIngredients[indexPath.row].strIngredient
            return cell
        }
        else if indexPath.section == 4{
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: tagCellIdenfier, for: indexPath) as! TagCell
            cell.tagName.text =  "Something"
            return cell
        }
        else {
            let cell  =  collectionView.dequeueReusableCell(withReuseIdentifier: cellNewArrivalsIdentifier, for: indexPath) as! ProductCell
            //        cell.tagName.text =  featuredIngredients[indexPath.row].strIngredient
            return cell
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
      
        
        if indexPath.section == 1{
            let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: newArrivalsHeaderId, for: indexPath) as! Header
            header.label.text  =   "New Arrivals "
            return header
        }else if indexPath.section == 2{
            let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: featureProductHeaderId, for: indexPath) as! Header
            header.label.text  =   "Feature Product"
            return header
        }
        
        else if indexPath.section == 3{
            let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: recommendedHeaderId, for: indexPath) as! Header
            header.label.text  =   "Recommended For You"
            return header
        }
        else if indexPath.section == 4{
            let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: tagPopularSearchHeaderId, for: indexPath) as! Header
            header.label.text  =   "Popular Searches"
            return header
        }
            
            
            
            
        let header =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: featureProductHeaderId, for: indexPath) as! Header
        return header
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let controller  = ProductViewController(product:  allproducts[indexPath.row])
      
            navigationController?.pushViewController(controller, animated: true)
            
            
            
        }
    }
    
    
}
    
    
    
    

class Header : UICollectionReusableView {

    var label : UILabel  = {
        let label = UILabel()
        label.text =  "Categories"
        label.font =  UIFont.boldSystemFont(ofSize: 24)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var viewAllLabel : UILabel =  {
        let label =  UILabel()
        label.text =  "View All"
        label.textColor =  .systemBlue
        label.font =  UIFont.systemFont(ofSize: 18)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.anchor(top: nil, left: leadingAnchor, right: nil, bottom: nil, paddingTop: nil, paddingLeft: 0, paddingRight: nil, paddingBottom: nil, width: nil, height: nil)
        label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive  = true
    }

    }



