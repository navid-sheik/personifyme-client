//
//  CheckoutController2.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 06/08/2023.
//

import Foundation
import UIKit
import StripePaymentSheet
import Stripe


class CheckoutViewController2: UIViewController {
    var checkoutButton: CustomButton =  {
        let button = CustomButton(title: "Checkout",hasBackground: true , fontType: .medium)
        return button
    }()
  var paymentSheet: PaymentSheet?
  let backendCheckoutUrl = URL(string: "https://4c5e-2a02-6b66-ea39-0-b101-2549-9aaf-85a8.ngrok-free.app")! // Your backend endpoint

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
      view.addSubview(checkoutButton)
      checkoutButton.anchor( top: nil, left: self.view.leadingAnchor, right: self.view.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: 50)
      checkoutButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
      
      
      
  
      
      

    checkoutButton.addTarget(self, action: #selector(didTapCheckoutButton), for: .touchUpInside)
    checkoutButton.isEnabled = false

    // MARK: Fetch the PaymentIntent client secret, Ephemeral Key secret, Customer ID, and publishable key
    var request = URLRequest(url: backendCheckoutUrl)
    request.httpMethod = "POST"
    let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
      guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
            let customerId = json["customer"] as? String,
            let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
            let paymentIntentClientSecret = json["paymentIntent"] as? String,
            let publishableKey = json["publishableKey"] as? String,
            let self = self else {
        // Handle error
        return
      }

      STPAPIClient.shared.publishableKey = publishableKey
      // MARK: Create a PaymentSheet instance
      var configuration = PaymentSheet.Configuration()
      configuration.merchantDisplayName = "Example, Inc."
      configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
      // Set `allowsDelayedPaymentMethods` to true if your business can handle payment
      // methods that complete payment after a delay, like SEPA Debit and Sofort.
      configuration.allowsDelayedPaymentMethods = true
      self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)

      DispatchQueue.main.async {
        self.checkoutButton.isEnabled = true
      }
    })
    task.resume()
  }
    
    
    @objc func didTapCheckoutButton() {
      // MARK: Start the checkout process
      paymentSheet?.present(from: self) { paymentResult in
        // MARK: Handle the payment result
        switch paymentResult {
        case .completed:
          print("Your order is confirmed")
        case .canceled:
          print("Canceled!")
        case .failed(let error):
          print("Payment failed: \(error)")
        }
      }
    }

}
