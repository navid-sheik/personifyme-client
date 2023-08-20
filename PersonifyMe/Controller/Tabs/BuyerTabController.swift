//
//  BuyerTabController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 26/07/2023.
//

import UIKit


protocol CartUpdateDelegate : class{
    func addProductToCart(_ cartItem: CartItemSend?)
    func emptyCart()
}

class BuyerTabController: UITabBarController {
    
    var sellerConroller : RestrictedController =  OnBoardingLaunchViewController()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        
        //        tabBar.barTintColor =  .lightGray
        tabBar.unselectedItemTintColor =  .lightGray
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.white
        
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white // change to your preferred color
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        
        // Do any additional setup after loading the view.
        setUpTabs()
        fetchCartData()
       
    }
    
    
    func fetchCartData(){
        DispatchQueue.global(qos: .background).async {
            // This is run on the background queue
            Service.shared.fetchCart(expecting: ApiResponse<Cart>.self) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let response ):
                    guard let cart = response.data else {return}
                    print(cart)
                    
                    
                    DispatchQueue.main.async {
                        // Once the background task is finished, this code will run on the main queue
                        
                        // Access the CartViewController and update the cart
                        if let navController = self.viewControllers?[4] as? UINavigationController,
                           let cartVC = navController.viewControllers.first as? CartViewController {
            
                            cartVC.cart = cart
                        
                            
                            self.updateCartTag(cart.items.count)
                        }
                    }
                case .failure(let error):
                    print(error)
                    
                }
                
            }
            
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("disappeared")
        Service.shared.checkSellerStatus(expecting: SellerResponse.self) { [weak self] result in
            switch result{
                
                
            case .success(let data):
                print(data)
                let hasStartedOnboarding =  data.result.hasStartedOnboarding
                
//                let hasCompletedOnboarding =  data.result.hasCompletedOnboarding
//
//
                print(hasStartedOnboarding)
                
                
                if (hasStartedOnboarding){
                    
                    DispatchQueue.main.async {  [weak self]  in
                        let vc = DashboardViewController(alreadyFetchedInfo: false)
                    
                        vc.navigationItem.largeTitleDisplayMode = .automatic
                        let nav = UINavigationController(rootViewController: vc)
                        nav.tabBarItem = UITabBarItem(title: "Seller",
                                                      image: UIImage(systemName: "dollarsign.square"),
                                                      tag: 3)
                        nav.navigationBar.prefersLargeTitles = true
                        self?.viewControllers?[2] = nav
                        
                    }
                    
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
        cartVC.delegate = self
        let profileVC =  ProfileController()
        let layout  = UICollectionViewFlowLayout()
        
       
        
        let becomeSellerVC = sellerConroller
    
        
        
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        likesVC.navigationItem.largeTitleDisplayMode = .automatic
        becomeSellerVC.navigationItem.largeTitleDisplayMode = .automatic
        profileVC.navigationItem.largeTitleDisplayMode = .automatic
        cartVC.navigationItem.largeTitleDisplayMode = .automatic
        
        
        var nav3 = UINavigationController(rootViewController: becomeSellerVC)
        if let onBoardingVC = becomeSellerVC as? OnBoardingLaunchViewController {
            onBoardingVC.delegate = self
            nav3 = UINavigationController(rootViewController: onBoardingVC)
            
        }
        
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: likesVC)
       
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
        
        nav5.tabBarItem.badgeValue = "0"
        
        
        
        for nav in [nav1, nav2, nav3, nav4, nav5] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1, nav2, nav3, nav4, nav5],
            animated: true
        )
    }
}
extension BuyerTabController: CartUpdateDelegate{
    func emptyCart() {
        self.updateCartTag(0)
    }
    
    func addProductToCart(_ cartItem: CartItemSend?) {
        
        guard let item =  cartItem else {return}
    
        
        Service.shared.addProductToCart(item, expecting: ApiResponse<Cart>.self) { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let response):
                guard let cart =  response.data else {return}
                
                DispatchQueue.main.async {
                    // Once the background task is finished, this code will run on the main queue
                    
                    // Access the CartViewController and update the cart
                    if let navController = self.viewControllers?[4] as? UINavigationController,
                       let cartVC = navController.viewControllers.first as? CartViewController {
        
                        cartVC.cart = cart
                        
                        self.updateCartTag(cart.items.count)
                      
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
       
        
    }
    
    func updateCartTag(_ count: Int) {
        // Setting the badge value
        self.tabBar.items?[4].badgeValue = "\(count)"
        
        
    }

    
    func bounceTabBarItem(at index: Int) {
        guard let tabBar = self.tabBarController?.tabBar,
              index < tabBar.subviews.count else {
            return
        }
        
        let targetView = tabBar.subviews[index + 1] // +1 due to the background view of the tabBar
        let animation = bounceAnimation()
        targetView.layer.add(animation, forKey: nil)
    }
    
    func bounceAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        animation.duration = 0.4
        animation.calculationMode = CAAnimationCalculationMode.cubic
        return animation
    }

    // Trigge

    
    
}



extension BuyerTabController: OnBoardingLaunchViewControllerDelegate{
    func updateTabController(onBoardingData: OnBoardingData) {
        DispatchQueue.main.async {
            // Step 0: Switch to another tab if the user is currently on the tab that's going to be replaced
            if self.selectedIndex == 2 {
                
                // Capture a snapshot of the current view
                if let snapshot = self.selectedViewController?.view.snapshotView(afterScreenUpdates: false) {
                    self.view.addSubview(snapshot)

                    // Switch the index to change the tab
                    self.selectedIndex = 0

                    // Animate the snapshot view out
                    UIView.animate(withDuration: 0.3, animations: {
                        snapshot.alpha = 0
                    }, completion: { _ in
                        snapshot.removeFromSuperview()
                    })
                }
            }

            // Step 1: Create the new ViewController
            let vc = DashboardViewController(alreadyFetchedInfo: true)
            vc.onBoardingInfo = onBoardingData
            vc.navigationItem.largeTitleDisplayMode = .automatic
            let nav = UINavigationController(rootViewController: vc)
            nav.tabBarItem = UITabBarItem(title: "Seller", image: UIImage(systemName: "dollarsign.square"), tag: 3)
            nav.navigationBar.prefersLargeTitles = true

            // Step 2: Replace the old ViewController with the new one in the TabBarController
            var vcs = self.viewControllers  // Get the current list of view controllers
            vcs?[2] = nav  // Replace the one you want to remove with the new one
            self.setViewControllers(vcs, animated: false)  // Update without animation

            // Step 3: Optionally, switch to the new tab programmatically with animation
            UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.selectedIndex = 2
            }, completion: nil)
        }
    }




}
    
    
    

