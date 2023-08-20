//
//  SettingCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 09/08/2023.
//

import Foundation
import UIKit

protocol SettingTableViewCellDelegate: AnyObject {
    func switchValueChanged(for cell: SettingTableViewCell, with settingOption: SettingOption, isOn: Bool)
    func editButtonTapped(for cell: SettingTableViewCell, with settingOption: SettingOption, value : String?)
}


 
class SettingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SettingTableViewCell"
    
    var isEnabled: Bool = false {
         didSet {
             if isEnabled {
                 enableTextField()
             } else {
                 disableTextField()
             }
         }
     }
    
    var value : String?

    
    weak var delegate: SettingTableViewCellDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var  textField : UITextField = {
        let textField = UITextField()
//        let spacer  =  UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.leftView =  spacer
        textField.leftViewMode =  .always
        textField.textColor =  .lightGray
        textField.keyboardAppearance =  .dark
        textField.backgroundColor =  UIColor(white: 1, alpha: 0.1)
        textField.placeholder = "Option value"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.gray
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = true
  
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        return switchControl
    }()
    
    let editButton: CustomButton = {
        let button  = CustomButton(title: "Edit", hasBackground: true,  fontType: .small)
        return button
    }()
    
    var currentSettingOption: SettingOption?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textField)
        contentView.addSubview(switchControl)
        contentView.addSubview(editButton)
        
        
        
        let width =  contentView.frame.width / 4
        
        
        let stack = StackManager.createStackView(with: [titleLabel, textField], axis: .vertical , spacing: 10, distribution: .fillProportionally, alignment: .leading)
        
        addSubview(stack)
        stack.anchor( top: nil, left: contentView.leadingAnchor, right: nil, bottom: nil , paddingTop: 5, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
//        subtitleLabel.anchor( top: titleLabel.bottomAnchor, left: contentView.leadingAnchor, right: nil, bottom: nil , paddingTop: 5, paddingLeft: 5,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
//
        switchControl.anchor( top: nil, left: nil, right: self.trailingAnchor, bottom: nil , paddingTop: 0, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        editButton.anchor( top: nil, left: nil, right: self.trailingAnchor, bottom: nil , paddingTop: 0, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: width, height: 30)
        
        editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        switchControl.isHidden = true
        editButton.isHidden = true
    }
    
    func configure(with settingOption: SettingOption) {
        titleLabel.text = settingOption.description
        textField.text = settingOption.customValue
        self.value =  settingOption.customValue
        switchControl.isHidden = true
        editButton.isHidden = true
        textField.isHidden = true
        
        if settingOption.isSwitchable {
            switchControl.isHidden = false
            
        } else if settingOption.isSelectable {
            editButton.isHidden = false
            textField.isHidden = false
      
        }
        
        currentSettingOption = settingOption
    }
    
    @objc func switchValueChanged() {
        
        if let settingOption = currentSettingOption {
            delegate?.switchValueChanged(for: self, with: settingOption, isOn: switchControl.isOn)
        }
    }
    
    @objc func editButtonTapped() {
        
        
        isEnabled.toggle()
        guard let value =  self.value else { return }
//        if value != textField.text{
            if let settingOption = currentSettingOption, settingOption.isSelectable {
                delegate?.editButtonTapped(for: self , with: settingOption, value: self.value as String?)
            }
//        }
        
    }
    
    func enableTextField() {
            textField.isEnabled = true
            textField.becomeFirstResponder()
            editButton.setTitle("Done", for: .normal)
        }
        
    // Function to disable the text field
    func disableTextField() {
        
        if let text =  textField.text  ,  text != "" {
            self.value =  text
        }else {
            textField.text = self.value
        
        }
        textField.isEnabled = false
        textField.resignFirstResponder()
        editButton.setTitle("Edit", for: .normal)
    }
    
}
