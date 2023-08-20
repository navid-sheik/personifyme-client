//
//  BalanceViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 09/08/2023.
//



import Foundation


import UIKit

class BalanceViewController: UIViewController {
    
    let payoutCellIdenfieri : String = "payoutCellIdenfieri"
    
    var stripePayouts : [StripePayoutDetail] = []{
        didSet{
            self.collectionView.reloadData()
            
        }
    }
    
    // MARK: - Components
    // Here you add all components
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "IMPULSE BUY"
        return label
    }()
    
    
    let balancePlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Balance:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let balanceValue  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00 USD"
        label.textAlignment =  .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        return label
    }()
    
    //AVAILABLE
    
    let availablePlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Available:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let availableValue  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00 USD"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.textAlignment =  .right
        return label
    }()
    
    
    let payoutPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Payout:"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    let payoutValue  : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$0.00 USD"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.gray
        label.textAlignment =  .right
        return label
    }()
    
    
    
    
    //READY TO PAYOUT
    let payoutHistoryPlaceholder : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Payout History"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.gray
        return label
    }()
    
 
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground

        return collectionView
    }()
    
    
    
    
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        navigationItem.title = "Balance"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupCollectionView()
        setupUI()
        fetchBalance()
        fetchHistory()
    }
    
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PayoutHistoryCell.self, forCellWithReuseIdentifier: payoutCellIdenfieri)
    }
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        let balanceStack  =  StackManager.createStackView(with: [balancePlaceholder, balanceValue], axis: .horizontal, distribution: .fillEqually, alignment: .center)
        
        
        let availableStack =  StackManager.createStackView(with: [availablePlaceholder, availableValue], axis: .horizontal, distribution: .fillEqually, alignment: .center)
        
        let payoutStack  =  StackManager.createStackView(with: [payoutPlaceholder, payoutValue], axis: .horizontal, distribution: .fillEqually, alignment: .center)
        
        
        
        
        
        
        
        let mainStack  = StackManager.createStackView(with: [balanceStack, availableStack, payoutStack], axis: .vertical, spacing: 10, distribution: .fillProportionally, alignment: .fill)
        
        mainStack.layer.borderColor =  UIColor.gray.cgColor
        mainStack.layer.borderWidth = 0.5
        mainStack.layer.cornerRadius =  5
        mainStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        view.addSubview(mainStack)
        
        mainStack.anchor( top: view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        

        view.addSubview(payoutHistoryPlaceholder)
        
        payoutHistoryPlaceholder.anchor(top: mainStack.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        view.addSubview(collectionView)
        collectionView.anchor(top: payoutHistoryPlaceholder.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 10, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    }
    
    
    func fetchBalance(){
        Service.shared.getStripeBanlance(expecting: ApiResponse<Int>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
                
                
            case .success(let response):
                guard let balance = response.data else {return}
                
                DispatchQueue.main.async {
                    
                    self.balanceValue.text = "$\(StripeManager.convertStripeAmountToDouble(balance))"
                
                }
            case .failure(let error):
                
                print("Failed to get the balaence")
                print(error)
            }
        }
    }
    
    
    
    func fetchHistory (){
        Service.shared.getStripePayouts(expecting: ApiResponse<StripePayout>.self) { [weak self] result in
            guard let self = self else {return}
            switch result{
                
                
            case .success(let response):
                guard let payout = response.data else {return}
                
                DispatchQueue.main.async {
                    self.stripePayouts =  payout.payouts
                    self.availableValue.text =  "\(StripeManager.convertStripeAmountToDouble(payout.totalPendingPayouts))"
                    self.payoutValue.text =  "\(StripeManager.convertStripeAmountToDouble(payout.totalBalancePaidOut))"
                    
                
                }
            case .failure(let error):
                
                print("Failed to get the balaence")
                print(error)
            }
        }
    }
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}


extension BalanceViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stripePayouts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        //User NOrmal cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: payoutCellIdenfieri, for: indexPath) as! PayoutHistoryCell
        cell.payout = stripePayouts[indexPath.row]
        
        
        return cell
            
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width ,height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    
    
}
