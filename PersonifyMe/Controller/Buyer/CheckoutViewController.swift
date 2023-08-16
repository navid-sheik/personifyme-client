//
//  CheckoutViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 06/08/2023.
//

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import UIKit
import StripePaymentSheet

//class CheckoutViewControllerPrevious: UIViewController {
//
//    private static let backendURL = URL(string: "https://68c2-2a02-6b66-ea39-0-543b-3bc4-f0ff-5729.ngrok-free.app")!
//
//
//    private var paymentIntentClientSecret: String?
//    private lazy var addressViewController: AddressViewController? = {
//      return AddressViewController(configuration: self.addressConfiguration, delegate: self)
//    }()
//
//    private var addressDetails: AddressViewController.AddressDetails?
//
//    private var addressConfiguration: AddressViewController.Configuration {
//        return AddressViewController.Configuration(additionalFields: .init(phone: .optional))
//    }
//
//    private lazy var addressButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("Add shipping address", for: .normal)
//        button.backgroundColor = .systemIndigo
//        button.layer.cornerRadius = 5
//        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
//        button.addTarget(self, action: #selector(didTapShippingAddressButton), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    private lazy var payButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle("Pay now", for: .normal)
//        button.backgroundColor = .systemIndigo
//        button.layer.cornerRadius = 5
//        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
//        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isEnabled = false
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        StripeAPI.defaultPublishableKey = "pk_test_51NYyrYB6nvvF5Xeh38vBBJ9xWCtNKsSLuFexpx3A9nTpOAj9TZTLTRdRuo5cJbJusInPeXJo0LH1zoW3NHSDLtGZ00LrL4fvI5"
//
//        view.backgroundColor = .systemBackground
//        view.addSubview(payButton)
//
//        NSLayoutConstraint.activate([
//            payButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            payButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
//        ])
//
//        view.addSubview(addressButton)
//
//        NSLayoutConstraint.activate([
//            addressButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            addressButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            addressButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
//        ])
//
//        self.fetchPaymentIntent()
//    }
//
//    func fetchPaymentIntent() {
//        let url = Self.backendURL.appendingPathComponent("/create-payment-intent")
//
//        let shoppingCartContent: [String: Any] = [
//            "items": [
//                ["id": "xl-shirt"]
//            ]
//        ]
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONSerialization.data(withJSONObject: shoppingCartContent)
//
//        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
//
//            guard
//                let response = response as? HTTPURLResponse,
//                response.statusCode == 200,
//                let data = data,
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
//                let clientSecret = json["clientSecret"] as? String
//            else {
//                let message = error?.localizedDescription ?? "Failed to decode response from server."
//                self?.displayAlert(title: "Error loading page", message: message)
//                return
//            }
//
//            print("Created PaymentIntent")
//            self?.paymentIntentClientSecret = clientSecret
//
//            DispatchQueue.main.async {
//                self?.payButton.isEnabled = true
//            }
//        })
//
//        task.resume()
//    }
//
//    func displayAlert(title: String, message: String? = nil) {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(alertController, animated: true)
//        }
//    }
//
//    @objc
//    func pay() {
//        guard let paymentIntentClientSecret = self.paymentIntentClientSecret else {
//            return
//        }
//
//        var configuration = PaymentSheet.Configuration()
//        configuration.merchantDisplayName = "Example, Inc."
//        configuration.primaryButtonColor = UIColor(red: 1.0, green: 0.82, blue: 0.04, alpha: 1.0)
//        configuration.applePay = .init(
//            merchantId: "com.example.appname",
//            merchantCountryCode: "US"
//        )
//
////        configuration.shippingDetails = { [weak self] in
////            return self?.addressDetails
////        }
//        configuration.defaultBillingDetails.email = "foo@bar.com"
//        configuration.billingDetailsCollectionConfiguration.name = .always
//        configuration.billingDetailsCollectionConfiguration.email = .always
//        configuration.billingDetailsCollectionConfiguration.address = .automatic
//        configuration.billingDetailsCollectionConfiguration.attachDefaultsToPaymentMethod = true
//        configuration.allowsPaymentMethodsRequiringShippingAddress = true
//
//        let paymentSheet = PaymentSheet(
//            paymentIntentClientSecret: paymentIntentClientSecret,
//            configuration: configuration)
//
//
//        paymentSheet.present(from: self) { [weak self] (paymentResult) in
//            switch paymentResult {
//            case .completed:
//                self?.displayAlert(title: "Payment complete!")
//            case .canceled:
//                print("Payment canceled!")
//            case .failed(let error):
//                self?.displayAlert(title: "Payment failed", message: error.localizedDescription)
//            }
//        }
//    }
//
//    @objc
//    func didTapShippingAddressButton() {
//        present(UINavigationController(rootViewController: addressViewController!), animated: true)
//    }
//
//}
//
//// MARK: - AddressViewControllerDelegate
//
//extension CheckoutViewControllerPrevious: AddressViewControllerDelegate {
//    func addressViewControllerDidFinish(_ addressViewController: AddressViewController, with address: AddressViewController.AddressDetails?) {
//        addressViewController.dismiss(animated: true)
//        self.addressDetails = address
//    }
//}
//
//



class CheckoutViewController :UIViewController{
    
    
    weak var delegate: CartViewControllerDelegate?
    
    private static let backendURL = URL(string: "https://68c2-2a02-6b66-ea39-0-543b-3bc4-f0ff-5729.ngrok-free.app")!
    
//    var order : Order?{
//        didSet{
//            guard let order  = order else {return}
//            print(order)
//        }
//
//    }
    
    var paymentIntentId : String?
    var cart : Cart?{
        didSet{
            guard let cart  = cart else {return}
            let subtotal =  cart.totalPrice
            subTotalValue.text =  "$\( NumberFormatterService.formatToTwoDecimalPlaces(subtotal) )"
            self.tableOrderSummary.reloadData()
        }
    }
    
    private let identifierTablecell : String =  "identifierTablecell"

    private lazy var addressViewController: AddressViewController? = {
      return AddressViewController(configuration: self.addressConfiguration, delegate: self)
    }()
    
    private var addressDetails: AddressViewController.AddressDetails?
    
    private var addressConfiguration: AddressViewController.Configuration {
        return AddressViewController.Configuration(additionalFields: .init(phone: .optional))
    }
    
    
    private var paymentIntentClientSecret: String?
    private var paymentSheetFlowController: PaymentSheet.FlowController!
        
    
    
   
    
    private let checkoutLabel : UILabel = {
        let label = UILabel()
        label.text = "Checkout"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    
    private let shippingLabel : UILabel = {
        let label = UILabel()
        label.text = "Shipping"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    private lazy var addressView: AddressCheckoutView = {
        let view = AddressCheckoutView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var selectShippingAddress: AddressCheckoutView = {
        let view = AddressCheckoutView()
        view.addressLabel.text = "Select Shipping Address"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let paymentLabel : UILabel = {
        let label = UILabel()
        label.text = "Payment"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    private lazy var paymentView: PaymentMethodView = {
        let view = PaymentMethodView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let buyBUtton : CustomButton = {
        let button  = CustomButton(title: "Pay", hasBackground: true,  fontType: .medium)
        button.isEnabled = false
        return button
    }()
    
    
    private let orderSummary : UILabel = {
        let label = UILabel()
        label.text = "Order Summary"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    let tableOrderSummary : DynamicTableView = {
        let table = DynamicTableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        table.isScrollEnabled = false
//        table.layer.shadowOpacity = 0.5
//        table.layer.shadowRadius = 5.0
//        table.layer.shadowColor = UIColor.black.cgColor
//        table.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        table.layer.masksToBounds = false
    
//        table.rowHeight = UITableView.automaticDimension
//        table.estimatedRowHeight = 95
//
//
    
        
      
        return table
    }()
    
    
    private let subTotalLabel : UILabel = {
        let label = UILabel()
        label.text = "Subtotal"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    private var subTotalValue : UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    private let shippingCostLabel : UILabel = {
        let label = UILabel()
        label.text = "Shipping"
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    private var shippingCostValue : UILabel = {
        let label = UILabel()
        label.text = "FREE Delivery"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    
    private let taxLabel : UILabel = {
        let label = UILabel()
        label.text = "Tax"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
    private var taxValue : UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor =  .lightGray
        return label
    }()
    
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
    
    
    
    
 
    
    
    
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Place Your Order"
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDonePressed))
        
        // Set the button to the right side of the navigation bar
        self.navigationItem.rightBarButtonItem = doneButton
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapShippingAddress))
        addressView.addGestureRecognizer(tapGesture)
        
        let tapGesturePayment = UITapGestureRecognizer(target: self, action: #selector(didTapPaymentMethod))
        paymentView.addGestureRecognizer(tapGesturePayment)
        
        
        buyBUtton.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        setUpUI()
        setUpTableView()
        fetchPaymentIntent()
        
        
    }
    
    
    private func setUpUI(){
        
        // Add the scrollView to the main view
        view.addSubview(containerScrollView)
        containerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        // Add the contentView to the scrollView
        containerScrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true

        // Now, add all other views to the contentView
        contentView.addSubview(shippingLabel)
        contentView.addSubview(addressView)
        contentView.addSubview(selectShippingAddress)
        contentView.addSubview(paymentLabel)
        contentView.addSubview(paymentView)
   
        contentView.addSubview(orderSummary)
        contentView.addSubview(tableOrderSummary)

        // Set constraints for each subview added to contentView
        shippingLabel.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        addressView.anchor(top: shippingLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 50)
        
        selectShippingAddress.anchor(top: addressView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: -1, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 50)
        
        paymentLabel.anchor(top: selectShippingAddress.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        paymentView.anchor(top: paymentLabel.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: 50)
        
        orderSummary.anchor(top: paymentView.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
       
        tableOrderSummary.anchor(top: orderSummary.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: nil, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

        let stackViewSubTotal = StackManager.createStackView(with: [subTotalLabel, subTotalValue], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .fill)
        
        let stackViewShipping = StackManager.createStackView(with: [shippingCostLabel, shippingCostValue], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .fill)
        
        let stackViewTax = StackManager.createStackView(with: [taxLabel, taxValue], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment: .fill)
        
        let mainStack = StackManager.createStackView(with: [stackViewSubTotal, stackViewShipping, stackViewTax], axis: .vertical, spacing: 10, distribution: .fillProportionally, alignment: .fill)
        
        contentView.addSubview(mainStack)
        mainStack.anchor(top: tableOrderSummary.bottomAnchor, left: contentView.leadingAnchor, right: contentView.trailingAnchor, bottom: contentView.bottomAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: -10, paddingBottom: 20, width: nil, height: nil)

        
        view.addSubview(buyBUtton)
        buyBUtton.anchor(top: nil, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: -10, paddingBottom: -10, width: nil, height: 50)
    }

    
    
    func setUpTableView(){
        self.tableOrderSummary.dataSource = self
        self.tableOrderSummary.delegate = self
        self.tableOrderSummary.register(SingleOrderProduct.self, forCellReuseIdentifier: identifierTablecell)
    }
    
    func fetchPaymentIntent() {
        self.paymentView.isUserInteractionEnabled = false
        
        Service.shared.createPaymentIntent(expecting: OrderCheckout.self, completion: { (result) in
            switch result {
            case .success(let response):
//                guard let data = response  else { return }
//                let order = response.order
                let clientSecret = response.paymentIntent
               let publishableKey = response.publishableKey
                let payment_id =  response.payment_intent_id
                DispatchQueue.main.async {
                    self.paymentView.isUserInteractionEnabled = true
                    self.paymentIntentClientSecret = clientSecret
                    self.paymentIntentId =  payment_id
                    
//                    self.order = order
//
                    // MARK: Set your Stripe publishable key - this allows the SDK to make requests to Stripe for your account
                    STPAPIClient.shared.publishableKey = publishableKey
                    
                    // MARK: Create a PaymentSheet.FlowController instance
                    var configuration = PaymentSheet.Configuration()
                    configuration.merchantDisplayName = "Example, Inc."
                    configuration.applePay = .init(
                        merchantId: "com.foo.example", merchantCountryCode: "US")
                    
                    configuration.billingDetailsCollectionConfiguration.name = .automatic
                    configuration.billingDetailsCollectionConfiguration.email = .automatic
                    configuration.billingDetailsCollectionConfiguration.address = .automatic
                    configuration.billingDetailsCollectionConfiguration.attachDefaultsToPaymentMethod = true
                    
                    // configuration.customer = .init(
                    // id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
                    
                    configuration.returnURL = "personifyme://payment-result"
                    // Set allowsDelayedPaymentMethods to true if your business can handle payment methods that complete payment after a delay, like SEPA Debit and Sofort.
                    configuration.allowsDelayedPaymentMethods = false
                    
                    PaymentSheet.FlowController.create(
                        paymentIntentClientSecret: self.paymentIntentClientSecret!,
                        configuration: configuration
                    ) { [weak self] result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let paymentSheetFlowController):
                            self?.paymentSheetFlowController = paymentSheetFlowController
                            print("Success")
            
                            self?.paymentView.isUserInteractionEnabled = true
                            
                            // self?.paymentMethodButton.isEnabled = true
                            // self?.updateButtons()
                            
                            self?.updateBUtton()
                        }
                    }
                    
                    print("client secret is \(clientSecret)")
                    
                    
                    
                }
                
                
                
            case .failure(let error):
                print("Failed to create payment intent: \(error.localizedDescription)")
            }
        })
    }

    
    //MARK: - Helpers
//    func updateButtons() {
//           // MARK: Update the payment method and buy buttons
//           if let paymentOption = paymentSheetFlowController.paymentOption {
//               paymentMethodButton.setTitle(paymentOption.label, for: .normal)
//               paymentMethodButton.setTitleColor(.black, for: .normal)
//               paymentMethodImage.image = paymentOption.image
//               buyButton.isEnabled = true
//           } else {
//               paymentMethodButton.setTitle("Select", for: .normal)
//               paymentMethodButton.setTitleColor(.systemBlue, for: .normal)
//               paymentMethodImage.image = nil
//               buyButton.isEnabled = false
//           }
//       }

       func displayAlert(_ message: String) {
           let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) { (_) in
               alertController.dismiss(animated: true) {
                   self.navigationController?.popViewController(animated: true)
               }
           }
           alertController.addAction(OKAction)
           present(alertController, animated: true, completion: nil)
       }
    
    //MARK: - METHODS
    
    @objc
    func didTapShippingAddress() {
        if let addressVC = addressViewController {
            self.present(UINavigationController(rootViewController: addressVC), animated: true)
            
        }
    }
    
    @objc func didTapPaymentMethod(){
        paymentSheetFlowController.presentPaymentOptions(from: self) {
            // Check if a payment option is available
            self.updateBUtton()
        }
    }
    
    
    @objc func  didTapBuyButton(){
                
        
        // MARK: Confirm payment
               
               paymentSheetFlowController.confirm(from: self) { paymentResult in
                   // MARK: Handle the payment result
                   switch paymentResult {
                   case .completed:
                    
                       self.createOrder()
//                       self.displayAlert("Your order is confirmed!")
                   case .canceled:
                       print("Canceled!")
                   case .failed(let error):
                       print(error)
                       self.displayAlert("Payment failed: \n\(error.localizedDescription)")
                   }
               }
    }
    
    @objc func handleDonePressed() {
        // If this view controller was presented modally
        self.dismiss(animated: true, completion: nil)

        // If it's pushed in a navigation stack
        // self.navigationController?.popViewController(animated: true)
    }
    
    func updateBUtton(){
        if let paymentOption = self.paymentSheetFlowController.paymentOption {
            // Assuming the paymentOption has properties cardImage and lastFourDigits, you'd extract them here.
            // Adjust as per your actual paymentOption structure.
            let selectedCardImage = paymentOption.image // Example property
            let selectedLastFourDigits = paymentOption.label // Example property
            
            self.paymentView.setPaymentMethod(cardImage: selectedCardImage, lastFourDigits: selectedLastFourDigits)
            self.buyBUtton.isEnabled =  true
        }else {
            self.paymentView.setPaymentMethod(cardImage: nil, lastFourDigits: nil)
            self.buyBUtton.isEnabled =  false
            
        }
    }
    
   
    
    
    
   
    
    func updateOrder (){
//
//        guard let order = order else {return}
//        Service.shared.updateOrder(order.orderId, with: order, expecting: ApiResponse<Order>.self) { [weak self] result in
//            switch result{
//
//            case .success(let response ):
//                guard let order =  response.data else {return}
//
//                self?.order = order
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        
    }
    
    
    func createOrder (){
        guard let address =  addressDetails else {return}
        guard let pay_id = self.paymentIntentId else {return}
        let addressObject = Address(line1: address.address.line1, line2: address.address.line2, country: address.address.country, postalCode: address.address.postalCode, city: address.address.city, state: address.address.state, name: address.name, phone : address.phone)
        let order  =  Order(orderId: nil, userId: nil, shippingDetails: addressObject, transactionId: pay_id, orderTotal: nil, shippingCost: nil, createdAt: nil, updatedAt: nil)
        Service.shared.createNewOrder(order, expecting: ApiResponse<Order>.self) { [weak self]  result in
            guard let self = self else {return}
            switch result{
                
            case .success(let order):
                print("Sucess")
                guard let order =  order.data else {return}
                DispatchQueue.main.async {
                    let vc = OrderConfirmation()
                    vc.order  = order
                    vc.delegate = self.delegate
                    self.navigationController?.pushViewController(vc, animated: true)
                }

            case .failure(let error):
                print(error)
                print("Failure")
            }
        }
    }
    
    
    
}


extension CheckoutViewController: AddressViewControllerDelegate {
    
    func formattedAddress(from details: AddressViewController.AddressDetails?) -> String {
        guard let details = details else {
            return "Add shipping address"
        }

        let address = details.address
        var components = [String]()

        components.append(address.line1)

        if let line2 = address.line2, !line2.isEmpty {
            components.append(line2)
        }

        if let city = address.city, !city.isEmpty {
            components.append(city)
        }

        if let state = address.state, !state.isEmpty {
            components.append(state)
        }

        if let postalCode = address.postalCode, !postalCode.isEmpty {
            components.append(postalCode)
        }

        components.append(address.country)

        return components.joined(separator: ", ")
    }
    
    func addressViewControllerDidFinish(_ addressViewController: AddressViewController, with address: AddressViewController.AddressDetails?) {
        addressViewController.dismiss(animated: true)
          
            if let details = address {
                let addressString = formattedAddress(from: details)
              
                addressView.setAddress(addressString)
            } else {
                addressView.setAddress(nil)
            }
        self.addressDetails = address
    }
    
    
    
}






extension CheckoutViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifierTablecell, for: indexPath) as! SingleOrderProduct
        cell.selectionStyle =  .none
        guard let item = cart?.items[indexPath.row] else { return cell }
        cell.priceLabel.text =  "$\(item.price)"
    
        cell.quantityLabel.text  = "x\(item.quantity)"
        cell.productTitleLabel.text = item.productId.productTitle
        cell.productImageView.loadImageUrlString(urlString:  item.productId.productImages[0] )
        cell.variantLabel.text = item.variations.map { "\($0.variant): \($0.value)" }.joined(separator: ", ")
        
    
        return cell
    }
    
    
}
