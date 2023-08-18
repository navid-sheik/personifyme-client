//
//  ShopSelectableTextFiled .swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 18/08/2023.
//

import Foundation
import UIKit

class ShopSelectableTextFiled: UIView, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text  = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = .always
        textField.textColor = .lightGray
        textField.keyboardAppearance = .dark
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.placeholder = "Option value"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textColor = UIColor.gray
        textField.layer.cornerRadius = 2
        textField.layer.masksToBounds = true
        return textField
    }()
    
    let editButton: CustomButton = {
        let button  = CustomButton(title: "Select", hasBackground: true,  fontType: .small)
        return button
    }()
    
    var title: String
    var value: String
    
    var picker: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    var pickerData: [String] = [] {
        didSet {
            picker.reloadAllComponents()
        }
    }
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        textField.delegate = self
        textField.isEnabled = false
        textField.inputView = picker
        picker.dataSource = self
        picker.delegate = self
        
        textField.text = value
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.addSubview(editButton)
        self.addSubview(titleLabel)
        self.addSubview(textField)
        
        // Add your constraints here
        
        // Center editButton both vertically and horizontally
        titleLabel.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, paddingTop: 0, paddingLeft: 10,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        editButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        editButton.anchor( top: nil, left: nil, right: self.trailingAnchor, bottom: nil, paddingTop: 3, paddingLeft: 0,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        
        
        
        
        textField.anchor( top: self.titleLabel.bottomAnchor, left: self.leadingAnchor, right: editButton.leadingAnchor, bottom: nil, paddingTop: 3, paddingLeft: 10,paddingRight: 0, paddingBottom: 0, width: nil, height: 30)
        
        
        
        
        
        
        
        
    }
    
    var isEnabled: Bool = false {
        didSet {
            if isEnabled {
                showPicker()
            } else {
                hidePicker()
            }
        }
    }
    
    @objc func didTapEdit(){
        isEnabled.toggle()
    }
    
    func setText(value: String) {
        self.value = value
        textField.text = value
    }
    
    
    
    func showPicker() {
        textField.isEnabled = true
        textField.becomeFirstResponder()
        editButton.setTitle("Done", for: .normal)
    }
    
    func hidePicker() {
        if let text = textField.text, text != "" {
            self.value = text
        } else {
            textField.text = self.value
        }
        textField.isEnabled = false
        textField.resignFirstResponder()
        editButton.setTitle("Select", for: .normal)
    }
    
    func setPickerData(data: [String]) {
        self.pickerData = data
    }
    
    func getText() -> String {
        return self.value
    }
    
    // UIPickerViewDataSource and UIPickerViewDelegate Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = pickerData[row]
        textField.text = selectedValue
        self.value = selectedValue
    }
}
