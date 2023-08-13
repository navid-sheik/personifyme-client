//
//  VariationCell.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 12/08/2023.
//

import Foundation
import UIKit

protocol VariantCellDelegate: AnyObject {
    func cellDidBeginEditing(_ cell: VariantCell)
    func variantCell(_ cell: VariantCell, didUpdateVariant variant: Variant)
}
class VariantCell: UITableViewCell {
    // define icon and label
    
    weak var delegate: VariantCellDelegate?
    
    
    var variant: Variant? {
          didSet {
              configureVariantCell()
          }
    }
    
    var isFirst : Bool = false
    
    
   
    
      
    var  variantField : VariantField  = {
        let vField  = VariantField(isOption: false, isCompulsory: true)
        vField.label.text = "Name"
        vField.textField.placeholder = "Enter variant name"
        return vField
    }()
    
    var  optionField : VariantField  = {
        let vField  = VariantField(isCompulsory: true)
        return vField
    }()
    
    var number : Int = 1
   
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var addBUtton : UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(systemName:  "plus" ), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var deleteButton : CustomButton = {
        let button =  CustomButton(title: "Delete", hasBackground: true,  fontType: .small)
        return button
    }()
    
    let optionLabel : UILabel = {
        let label = UILabel()
        label.text = "Options"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameVariantLabel : UILabel = {
        let label = UILabel()
        label.text = "Variant Name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    
    var deleteVariant : UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(systemName:  "xmark" ), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

  
    
    override func prepareForReuse() {
        super.prepareForReuse()

        // Clear the variant data
        variant = nil

        // Clear all subviews from the stackView
        for subview in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        // Reset the text fields
        variantField.textField.text = ""
        optionField.textField.text = ""

        // Reset any other state variables, if necessary
        isFirst = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
        
        // Add the image view and label to the cell's content view
        variantField.textField.delegate = self
        optionField.textField.delegate = self
        optionField.textField.tag = number
        addBUtton.addTarget(self, action: #selector(addToOption), for: .touchUpInside)
     
        
//        contentView.addSubview(addBUtton)
//        addBUtton.anchor( top: self.contentView.topAnchor, left: nil, right:  self.contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

    
        
        
        
        var stackVariants = UIStackView()
        
        if isFirst {
             stackVariants =  StackManager.createStackView(with: [nameVariantLabel, deleteVariant], axis: .horizontal, spacing: 5, distribution: .fill,  alignment: .center)
        }else {
            
             stackVariants =  StackManager.createStackView(with: [nameVariantLabel], axis: .horizontal, spacing: 5, distribution: .fill,  alignment: .center)
            
            
        }

        
       
        
        
        contentView.addSubview(stackVariants)
        stackVariants.anchor( top: self.contentView.topAnchor, left:  self.contentView.leadingAnchor, right:  self.contentView.trailingAnchor, bottom: nil, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        contentView.addSubview(variantField)

        variantField.anchor( top: stackVariants.bottomAnchor, left:  self.contentView.leadingAnchor, right:  self.contentView.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
       

      
    
        let stackOption  =  StackManager.createStackView(with: [optionLabel, addBUtton], axis: .horizontal, spacing: 5, distribution: .fill,  alignment: .center)
        
        
        
        
        contentView.addSubview(stackOption)

        stackOption.anchor( top: variantField.bottomAnchor, left:  self.contentView.leadingAnchor, right:  nil, bottom: nil, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)

       
        contentView.addSubview(optionField)
        
        
        optionField.anchor( top:stackOption.bottomAnchor, left:  self.contentView.leadingAnchor, right:  self.contentView.trailingAnchor, bottom: nil, paddingTop: 5, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
        
  
        
        
        
        contentView.addSubview(stackView)
        stackView.anchor( top:optionField.bottomAnchor, left:  self.contentView.leadingAnchor, right:  self.contentView.trailingAnchor, bottom: self.contentView.bottomAnchor, paddingTop: 10, paddingLeft: 10 ,paddingRight: -10, paddingBottom: -10, width: nil, height: nil)
        
       
        
        // set accessoryType to display chevron to the left (instead of the default right)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) hasis not been implemented")
    }
    private func configureVariantCell() {
            guard let variantData = variant else { return }
            guard let variantName = variant?.name else { return }
            // Update text fields
            variantField.textField.text = variantName
            // Assuming optionTextField should be populated with the first option if available
            optionField.textField.text = variantData.options.first

            // Clear the stack view and populate with new options
            for subview in stackView.arrangedSubviews {
                stackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        
          

            
            // Create new views for other options in the variant and add them to the stack view
            for option in variantData.options.dropFirst() { // dropFirst() to skip the first option since it's in optionField
                let dynamicTextField = VariantField()  // Assuming you want to use VariantField
                dynamicTextField.textField.delegate = self
                dynamicTextField.textField.text = option
                dynamicTextField.delegate = self
                stackView.addArrangedSubview(dynamicTextField)
               
            }
          
            delegate?.cellDidBeginEditing(self)
        
    }

    
    
    
    
    @objc func addToOption() {
        // First, check if the variantField is not empty
        if let variantText = variantField.textField.text, !variantText.isEmpty {
            
            // If there's already a field in the stackView, check if it's not empty
            if let lastField = stackView.arrangedSubviews.last as? VariantField {
                if let text = lastField.textField.text, !text.isEmpty {
                    // Add a new VariantField to the stackView
                    let dynamicTextField = VariantField()
                    dynamicTextField.textField.delegate = self
                    dynamicTextField.delegate = self
                    stackView.addArrangedSubview(dynamicTextField)
                    stackView.layoutIfNeeded()  // Force layout update
                    delegate?.cellDidBeginEditing(self)
                } else {
                    // Display an alert or a message indicating the previous field should not be empty
                    print("The previous option value must not be empty!")
                }
                
            } else {
                // If the stack view has no subviews, check if optionField is not empty before adding the first one
                if let optionText = optionField.textField.text, !optionText.isEmpty {
                    let dynamicTextField = VariantField()
                    dynamicTextField.textField.delegate = self
                    dynamicTextField.delegate = self
                    stackView.addArrangedSubview(dynamicTextField)
                    stackView.layoutIfNeeded()  // Force layout update
                    delegate?.cellDidBeginEditing(self)
                } else {
                    // Display an alert or a message indicating the optionField should not be empty
                    print("The option value must not be empty!")
                }
            }
        } else {
            // Display an alert or a message indicating the variantField should not be empty
            print("The variant value must not be empty!")
        }
    }
         
        
    
    
    
    
    
    
    
}

extension VariantCell: VariantFieldDelegate {
    func variantFieldDidRequestDeletion(_ field: VariantField) {
       
    
        UIView.performWithoutAnimation {
            stackView.removeArrangedSubview(field)
            field.removeFromSuperview()
            guard let variantName = variantField.textField.text, !variantName.isEmpty else {
                print("Variant name is empty!")
                return
            }
            
            var options: [String] = []
            
            // Add the text from optionField if it's not empty
            if let optionText = optionField.textField.text, !optionText.isEmpty {
                options.append(optionText)
            }
            
            // Add the text from textFields in stackView
            for view in stackView.arrangedSubviews {
                if let variantField = view as? VariantField, let text = variantField.textField.text, !text.isEmpty {
                    options.append(text)
                }
            }
            
            // Only update if we have at least one option
            if !options.isEmpty {
                let variant = Variant(name: variantName, options: options)
                delegate?.variantCell(self, didUpdateVariant: variant)
            }
          
            self.layoutIfNeeded()
            
        }
        delegate?.cellDidBeginEditing(self)
        print(stackView.arrangedSubviews.count)
//        delegate?.cellDidBeginEditing(self)
//        print("Remove")
//        stackView.removeArrangedSubview(field)
//        field.removeFromSuperview()
//        self.layoutIfNeeded()  // Force immediate layout update
//        delegate?.cellDidBeginEditing(self)
    }
}


extension VariantCell: UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            guard let variantName = variantField.textField.text, !variantName.isEmpty else {
                print("Variant name is empty!")
                return
            }
            
            var options: [String] = []
            
            // Add the text from optionField if it's not empty
            if let optionText = optionField.textField.text, !optionText.isEmpty {
                options.append(optionText)
            }
            
            // Add the text from textFields in stackView
            for view in stackView.arrangedSubviews {
                if let variantField = view as? VariantField, let text = variantField.textField.text, !text.isEmpty {
                    options.append(text)
                }
            }
            
            // Only update if we have at least one option
            if !options.isEmpty {
                let variant = Variant(name: variantName, options: options)
                delegate?.variantCell(self, didUpdateVariant: variant)
            }
        }
    
    
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
        
  
       
    
    
}


