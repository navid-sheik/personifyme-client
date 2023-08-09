//
//  SettingViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 08/08/2023.
//

import Foundation

import UIKit

//
//  PersonifyMe
//
//  Created by Navid Sheikh on 27/07/2023.
//

import Foundation


import UIKit

class SettingViewController: UIViewController {
    private var settings: [SettingOption] = [
        .fullName("John Doe"),
        .email("john.doe@example.com"),
        .currency("USD"),
        .country("USA"),
        .primaryAddress("123 Main St, Anytown"),
        .primaryPayment("Credit Card - **** 1234"),
        .password("••••••••"),
        .pushNotification,
        .appearance,
        .aboutThisApp,
        .privacyPolicy,
        .termsOfService,
        .contactUs
    ]
    

    let settingCellIDentifier : String = "settingCellIDentifier"
    
    // MARK: - Components
    // Here you add all components
    let label : UILabel  =  {
        let label = UILabel()
        label.text  =  "Something"
        return label
    }()
    let tableViewSettings : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.separatorStyle = .none


        return table
    }()
    
    
    let contactUsButton : CustomButton = {
        let button =  CustomButton(title: "Contact Us",hasBackground: true,  fontType: .medium)
        return button
    }()
    

    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .systemBackground
        setUpNavigationView()
        setTableView()
        setupUI()
    }
    
    
    
    
    // MARK: - UI Setup
    private func setupUI() {
        // Set up all UI elements here
        view.addSubview(tableViewSettings)
        
        tableViewSettings.anchor( top: view.layoutMarginsGuide.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom:  view.bottomAnchor,  paddingTop: 10, paddingLeft: 0,paddingRight: 0, paddingBottom: -10, width: nil, height: nil)
        
//        view.addSubview(contactUsButton)
//        contactUsButton.anchor(top: tableViewSettings.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 0, paddingLeft: 20, paddingRight: 20, paddingBottom: -30, width: nil, height: 50)
//
    
        
    }
    
    private func setUpNavigationView(){
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(contactApp))
        navigationItem.rightBarButtonItem = barButtonItem
        
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Settings "
    }
    
    private func setTableView(){
        tableViewSettings.dataSource = self
        tableViewSettings.delegate = self
        tableViewSettings.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingCell")
        
    
//        tableViewSettings.register(BuyerOrderHeader.self, forHeaderFooterViewReuseIdentifier: settingCellIDentifier)
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
    @objc func contactApp(){
        print("Contact admin")
    }
    
    
}



extension SettingViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
       

        return  settings.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingTableViewCell
           
           let setting = settings[indexPath.row]
           cell.configure(with:setting)
           cell.delegate = self
           cell.selectionStyle =  .none
           return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    

}

extension SettingViewController : SettingTableViewCellDelegate {
    func switchValueChanged(for cell: SettingTableViewCell, with settingOption: SettingOption, isOn: Bool) {
        guard let indexPath = tableViewSettings.indexPath(for: cell) else {
            print("Failed to get indexPath for cell")
            return
        }
        
        // Ensure that the indexPath.row is within the range of the settings array.
        guard indexPath.row < settings.count else {
            print("IndexPath is out of range for settings array")
            return
        }
        
        // Only update if the settingOption is .fullName
    

        let updatedName = SettingOption.fullName("Name Sheikh")
        settings[indexPath.row] = updatedName
        tableViewSettings.reloadRows(at: [indexPath], with: .automatic)
    
    }
    
    func editButtonTapped(for cell: SettingTableViewCell, with settingOption: SettingOption) {
        print("Updated ")
    }
    
   

    
    
    
    
}





