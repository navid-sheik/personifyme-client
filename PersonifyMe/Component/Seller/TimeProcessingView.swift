//
//  TimeProcessingView.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 01/08/2023.
//

import Foundation
import UIKit


class TimeProcessingView: UIView{
    
    private var activeTextField: UITextField?
    private static var isPickerOpened = false
    private var isPickerOpened = false
    let start_range : Int
    let end_range : Int
    
    
    let minTextField :  UITextField = {
        let textField  = UITextField()
        textField.backgroundColor =  .secondarySystemBackground
        textField.layer.cornerRadius =  4
        textField.text =  "1"
        
        textField.returnKeyType =  .next
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textAlignment = .center
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
        
    }()
    
    let maxTextfield :  UITextField = {
        let textField  = UITextField()
        textField.backgroundColor =  .secondarySystemBackground
        textField.layer.cornerRadius =  4
        textField.text =  "3"
        textField.textAlignment = .center
        
        textField.returnKeyType =  .next
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 0))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        
        
    }()
    
    let separator : UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  .lightGray
        return view
    }()
    
    
    
    
    
    init(start_range: Int, end_range: Int) {
        self.start_range = start_range
        self.end_range = end_range
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func setUpView (){
        self.translatesAutoresizingMaskIntoConstraints = false
//        let menuClosure = {(action: UIAction) in
//
//              self.update(number: action.title)
//          }
//        button.menu = UIMenu(children: [
//                  UIAction(title: "option 1", state: .on, handler:
//                                      menuClosure),
//                  UIAction(title: "option 2", handler: menuClosure),
//                  UIAction(title: "option 3", handler: menuClosure),
//              ])
       
//        separator.heightAnchor .constraint(equalToConstant: 1).isActive =  true
        minTextField.delegate = self
        maxTextfield.delegate = self
        let timeStack  = UIStackView(arrangedSubviews: [minTextField , maxTextfield])
        timeStack.alignment = .fill
        timeStack.axis =  .horizontal
        timeStack.distribution = .fillEqually
        timeStack.translatesAutoresizingMaskIntoConstraints =  false
        timeStack.spacing = 20
        self.addSubview(timeStack)
        

        timeStack.anchor( top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
        
    }
    
    func update(number:String) {
        switch number {
        case "option 1":
            print("option 1 selected")
        case "option 2":
            print("option 2 selected")
        case "option 3":
            print("option 3 selected")
        default:
            print("Unknown option selected")
        }
    }

}


extension TimeProcessingView : UITextFieldDelegate, NumberPickerDelegate{
    func didSelectNumber(_ number: Int) {
        TimeProcessingView.isPickerOpened = false // Reset the static flag
        activeTextField?.text = "\(number)"
        activeTextField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.resignFirstResponder()
            if TimeProcessingView.isPickerOpened {
                return
            }
            activeTextField = textField // Keep track of the active text field
            TimeProcessingView.isPickerOpened = true
        
            let numbers = Array(1...10)
        
               if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                   let pickerHeight: CGFloat = 200
                   let pickerFrame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: pickerHeight)
                   let numberPickerView = NumberPickerView(numbers: numbers, frame: pickerFrame)
                   numberPickerView.delegate = self
                   window.addSubview(numberPickerView)
                   // Animation
                   UIView.animate(withDuration: 0.3) {
                       numberPickerView.frame = CGRect(x: 0, y: window.frame.height - pickerHeight, width: window.frame.width, height: pickerHeight)
                   }
               }

            // Rest of your code to open the picker
        }
}
