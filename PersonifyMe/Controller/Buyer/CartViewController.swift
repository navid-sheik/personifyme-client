//
//  CartViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//


import Foundation


import UIKit


protocol CartViewControllerDelegate: AnyObject {
    func emptyCart()
}


extension CartViewController:CartViewControllerDelegate {
    func emptyCart() {
        Service.shared.clearCart(expecting: ApiResponse<String>.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.cart = nil
                    self.delegate?.emptyCart()
                    let subTotal  =  0.00
                    self.subTotaValue.text =  "$\( NumberFormatterService.formatToTwoDecimalPlaces(subTotal) )"
                    self.tableViewProducts.reloadData()
                }
           
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
}
class CartViewController: UIViewController {
    
    
    // MARK: - Identifier
    let headerTableViewCellIdentifier : String = "headerTableViewCellIdentifier"
    let itemTableViewCell : String = "itemTableViewCell"
    weak var delegate : CartUpdateDelegate?
    
    // MARK: - VAriables
    var cart : Cart?{
        didSet{
            guard let cart = cart else {return }
            self.configureCell(cart)
            self.tableViewProducts.reloadData()
        }
    }
    
  
    // MARK: - Components
    // Here you add all components
    let tableViewProducts:  DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    
    let subTotalLabel : UILabel = {
        let label = UILabel()
        label.text = "Subtotal"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.gray
        
        return label
    }()
    
    let subTotaValue : UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.gray
        return label
    }()
    let checkoutButton : CustomButton = {
        let button =  CustomButton(title: "Checkout",hasBackground: true,  fontType: .medium)
        return button
    }()
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    //MARK: MAIN SCROLLVIEW
    lazy var containerScrollView :  UIScrollView =  {
        let sv =  UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.flashScrollIndicators()
        sv.isUserInteractionEnabled = true
        sv.contentInsetAdjustmentBehavior = .never
        return sv
    }()
    let contentView : UIView =  {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        checkoutButton.addTarget(self, action: #selector(handleCheckOut), for: .touchUpInside)
        setNavigationBar()
        setTableView()
        setupUI()
        
    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(containerScrollView)
        containerScrollView.addSubview(contentView)
        containerScrollView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
        contentView.addSubview(tableViewProducts)
        contentView.addSubview(subTotalLabel)
        contentView.addSubview(subTotaValue)
        contentView.addSubview(checkoutButton)
        
       
        
      

        
        
        
        tableViewProducts.anchor( top: contentView.layoutMarginsGuide.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
       
        
        subTotalLabel.anchor( top: self.tableViewProducts.bottomAnchor , left: self.contentView.leadingAnchor, right: nil, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
        subTotaValue.anchor( top: nil , left: nil, right: self.contentView.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        subTotaValue.centerYAnchor.constraint(equalTo: subTotalLabel.centerYAnchor).isActive = true
        
        
        checkoutButton.anchor( top: subTotalLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: self.contentView.bottomAnchor , paddingTop: 10, paddingLeft: 10,paddingRight: -10, paddingBottom: -50, width: nil, height: 50)
        
        
        
        
      

       
      
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateCheckoutButton()
    }
    
    private func setTableView (){
        tableViewProducts.delegate = self
        tableViewProducts.dataSource = self
        tableViewProducts.register(CartViewCell.self, forCellReuseIdentifier:  itemTableViewCell)
        tableViewProducts.register(CartHeader.self, forHeaderFooterViewReuseIdentifier: headerTableViewCellIdentifier)
        tableViewProducts.layoutIfNeeded()
    
    }
    
    private func setNavigationBar (){
        navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
//        appearance.shadowColor = UIColor.clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationItem.title =  "Your Cart"
        
    }
    
    func configureCell (_ cart: Cart){
        let subTotal  =  cart.totalPrice
        subTotaValue.text =  "$\( NumberFormatterService.formatToTwoDecimalPlaces(subTotal) )"
    }
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    @objc func handleCheckOut(){
        print("The item")
        
        if !(cart?.items.isEmpty ?? false) {
            let vc = CheckoutViewController()
            vc.delegate = self
            vc.cart = self.cart
            let navigationVc  = UINavigationController(rootViewController: vc)
            navigationVc.modalPresentationStyle = .fullScreen
            self.present(navigationVc, animated: true, completion: nil)
//            navigationController?.pushViewController(vc, animated: true)
        
        }
     
    }
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}


extension CartViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = cart?.items.count ?? 0
        return  items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  =  tableView.dequeueReusableCell(withIdentifier: itemTableViewCell) as! CartViewCell
        cell.cartItem = cart?.items[indexPath.row]
        cell.delegate = self
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: headerTableViewCellIdentifier) as! CartHeader
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  40
    }
    
    
    
    
}
extension CartViewController: CartViewCellDelegate{
    func updateCartItem(_ cell: CartViewCell, withItemCartId cartItemId: String, cartItem: CartItem) {
        print(cartItemId)
        print(cartItem.quantity)
        
        
        Service.shared.updateProductFromCart(cartItemId, cartItem, expecting: ApiResponse<Cart>.self) { [weak self] result in
            switch result{
            case .success(let response ):
                DispatchQueue.main.async {
                    self?.cart = response.data
                    if let indexPath = self?.tableViewProducts.indexPath(for: cell) {
                                   // Reload only the specific row
                              
                        self?.tableViewProducts.reloadRows(at: [indexPath], with: .none)
                        self?.updateCheckoutButton()
                        
                    }
                }
                
            
            case .failure(let error):
                print(error)
            
                    
            }
        }
    }
    
    

    
    func deleteCartItem(_ cell: CartViewCell, withItemCartId cartItemId : String) {
        print("delete")
        
        if let indexPath = tableViewProducts.indexPath(for: cell) {
            print("Number of items before deletion: \(cart?.items.count ?? 0)")
            Service.shared.deleteProductFromCart(cartItemId, expecting: ApiResponse<Cart>.self) { [weak self] result in
                guard let self = self else { return }
                
                switch result{
                    
                    
                case .success(_):
                    DispatchQueue.main.async {
                        self.cart?.items.remove(at: indexPath.row)
                        print("Number of items after deletion: \(self.cart?.items.count ?? 0)")

                        // Temporarily replace the deleteRows call with reloadData
                        self.tableViewProducts.reloadData()
                        self.updateCheckoutButton()
                    }
                case .failure(_):
                    print("Error in deleting")
                }
            }
           
            
            
        }
    }
    
    
    func updateCheckoutButton(){
        guard let count =  cart?.items.count else {return}
        if count > 0 {
            checkoutButton.isEnabled = true
           
        
        }else{
            checkoutButton.isEnabled = false
           
        }
        
    }
}


