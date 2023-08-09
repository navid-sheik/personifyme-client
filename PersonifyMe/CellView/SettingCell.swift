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
    func editButtonTapped(for cell: SettingTableViewCell, with settingOption: SettingOption)
}

class SettingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SettingTableViewCell"
    
    weak var delegate: SettingTableViewCellDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 12)
           label.textColor = .gray
        label.text = "Somethign"
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
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
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(switchControl)
        contentView.addSubview(editButton)
        
        
        
        let width =  contentView.frame.width / 4
        
        
        let stack = StackManager.createStackView(with: [titleLabel, subtitleLabel], axis: .vertical , spacing: 10, distribution: .fillProportionally, alignment: .leading)
        
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
        subtitleLabel.text = settingOption.customValue
        switchControl.isHidden = true
        editButton.isHidden = true
        
        if settingOption.isSwitchable {
            switchControl.isHidden = false
        } else if settingOption.isSelectable {
            editButton.isHidden = false
        }
        
        currentSettingOption = settingOption
    }
    
    @objc func switchValueChanged() {
        
        if let settingOption = currentSettingOption {
            delegate?.switchValueChanged(for: self, with: settingOption, isOn: switchControl.isOn)
        }
    }
    
    @objc func editButtonTapped() {
        if let settingOption = currentSettingOption, settingOption.isSelectable {
            delegate?.editButtonTapped(for: self , with: settingOption)
        }
    }
}
