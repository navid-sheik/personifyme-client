//
//  BuyerTabController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import UIKit

class BuyerTabController: UITabBarController {
    var sellerConroller : RestrictedController =  DashboardViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        
        tabBar.barTintColor =  .lightGray
        tabBar.unselectedItemTintColor =  .lightGray
        tabBar.tintColor =  .darkGray
        
        tabBar.isTranslucent = true
        
        // Do any additional setup after loading the view.
        setUpTabs()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Service.shared.checkSellerStatus(expecting: SellerResponse.self) { [weak self] result in
            switch result{
               
            case .success(let data):
                let hasStartedOnboarding =  data.result.hasStartedOnboarding
                
                let hasCompletedOnboarding =  data.result.hasCompletedOnboarding
                
                
                print(hasStartedOnboarding)
                
                
                if (hasStartedOnboarding){
                    self?.sellerConroller =  OnBoardingLinkViewController()
                }
                
                if (!hasStartedOnboarding && !hasCompletedOnboarding){
                    self?.sellerConroller =  OnBoardingLaunchViewController()
                }
                
            
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    
    // MARK: - Navigation
    
    private func setUpTabs() {
        let homeVC = HomeViewController()
        let likesVC = LikesViewController()
        let cartVC = CartViewController()
        let profileVC =  ProfileViewController()
        let layout  = UICollectionViewFlowLayout()
      
        let becomeSellerVC = sellerConroller
        
        
        
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        likesVC.navigationItem.largeTitleDisplayMode = .automatic
        becomeSellerVC.navigationItem.largeTitleDisplayMode = .automatic
        profileVC.navigationItem.largeTitleDisplayMode = .automatic
        becomeSellerVC.navigationItem.largeTitleDisplayMode = .automatic
        
        
        
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: likesVC)
        let nav3 = UINavigationController(rootViewController: becomeSellerVC)
        let nav4 = UINavigationController(rootViewController: profileVC)
        let nav5 = UINavigationController(rootViewController: cartVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Likes",
                                       image: UIImage(systemName: "heart"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Seller",
                                       image: UIImage(systemName: "dollarsign.square"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "You",
                                       image: UIImage(systemName: "person"),
                                       tag: 4)
        
        nav5.tabBarItem = UITabBarItem(title: "Basket",
                                       image: UIImage(systemName: "cart"),
                                       tag: 5)
        
        for nav in [nav1, nav2, nav3, nav4, nav5] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1, nav2, nav3, nav4, nav5],
            animated: true
        )
    }
}
    



