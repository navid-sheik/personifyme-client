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

class CheckoutViewController: UIViewController {

    private static let backendURL = URL(string: "https://05f7-2a02-6b66-ea39-0-3859-c1a7-b0e-22dd.ngrok-free.app")!

    private var paymentIntentClientSecret: String?
    private lazy var addressViewController: AddressViewController? = {
      return AddressViewController(configuration: self.addressConfiguration, delegate: self)
    }()

    private var addressDetails: AddressViewController.AddressDetails?

    private var addressConfiguration: AddressViewController.Configuration {
        return AddressViewController.Configuration(additionalFields: .init(phone: .optional))
    }

    private lazy var addressButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Add shipping address", for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(didTapShippingAddressButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Pay now", for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 5
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        StripeAPI.defaultPublishableKey = "pk_test_51NYyrYB6nvvF5Xeh38vBBJ9xWCtNKsSLuFexpx3A9nTpOAj9TZTLTRdRuo5cJbJusInPeXJo0LH1zoW3NHSDLtGZ00LrL4fvI5"

        view.backgroundColor = .systemBackground
        view.addSubview(payButton)

        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])

        view.addSubview(addressButton)

        NSLayoutConstraint.activate([
            addressButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            addressButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            addressButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
        ])

        self.fetchPaymentIntent()
    }

    func fetchPaymentIntent() {
        let url = Self.backendURL.appendingPathComponent("/create-payment-intent")

        let shoppingCartContent: [String: Any] = [
            "items": [
                ["id": "xl-shirt"]
            ]
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: shoppingCartContent)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
          
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let clientSecret = json["clientSecret"] as? String
            else {
                let message = error?.localizedDescription ?? "Failed to decode response from server."
                self?.displayAlert(title: "Error loading page", message: message)
                return
            }

            print("Created PaymentIntent")
            self?.paymentIntentClientSecret = clientSecret

            DispatchQueue.main.async {
                self?.payButton.isEnabled = true
            }
        })

        task.resume()
    }

    func displayAlert(title: String, message: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
        }
    }

    @objc
    func pay() {
        guard let paymentIntentClientSecret = self.paymentIntentClientSecret else {
            return
        }

        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Example, Inc."
        configuration.primaryButtonColor = UIColor(red: 1.0, green: 0.82, blue: 0.04, alpha: 1.0)
        configuration.applePay = .init(
            merchantId: "com.example.appname",
            merchantCountryCode: "US"
        )

        configuration.shippingDetails = { [weak self] in
            return self?.addressDetails
        }

        let paymentSheet = PaymentSheet(
            paymentIntentClientSecret: paymentIntentClientSecret,
            configuration: configuration)
        

        paymentSheet.present(from: self) { [weak self] (paymentResult) in
            switch paymentResult {
            case .completed:
                self?.displayAlert(title: "Payment complete!")
            case .canceled:
                print("Payment canceled!")
            case .failed(let error):
                self?.displayAlert(title: "Payment failed", message: error.localizedDescription)
            }
        }
    }

    @objc
    func didTapShippingAddressButton() {
        present(UINavigationController(rootViewController: addressViewController!), animated: true)
    }

}

// MARK: - AddressViewControllerDelegate

extension CheckoutViewController: AddressViewControllerDelegate {
    func addressViewControllerDidFinish(_ addressViewController: AddressViewController, with address: AddressViewController.AddressDetails?) {
        addressViewController.dismiss(animated: true)
        self.addressDetails = address
    }
}
