//
//  AddVariantController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 11/08/2023.
//

import Foundation


import UIKit





protocol AddVariantControllerDelegate : class {
    func saveNewVariation(variantsArray : [Variant]?)
}

class AddVariantController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    weak var delegate : AddVariantControllerDelegate?
    
    let variantCellIdentifer : String = "variantCellIdentifer"
    var variants: [Variant] = [Variant(name: nil, options: [])]
     
    
    

    
    let viewContainer  : UIView =  {
        let view =  UIView()
        view.backgroundColor   = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
 
        // Shadow configuration
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2) // x,y offset of the shadow
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.1 // opacity, 0.1 means 10% opaque
        view.layer.masksToBounds = false // this is important as we don't want to clip off the shadow
        return view
        
    }()
    
    // MARK: - Components
    // Here you add all components
    var  variantField : VariantField  = {
        let vField  = VariantField()
        
        return vField
    }()
    
    var  variantField2 : VariantField  = {
        let vField  = VariantField()
        
        return vField
    }()
    
    
    let tableViewVariants:  DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        tableView.alwaysBounceVertical = false
        
        return tableView
    }()
   
    
    
    // MARK: - Properties
    // All properties and variables you need in your ViewController
    init() {
     
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = .clear
        self.variantField.textField.delegate = self
        
        setUpTableView()
        setupUI()
    }
    
    
    
    private func setUpTableView(){
        tableViewVariants.delegate = self
        tableViewVariants.dataSource = self
        tableViewVariants.register(VariantCell.self, forCellReuseIdentifier: variantCellIdentifer)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        // Setup toolbar
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        

    
        view.addSubview(viewContainer)

        viewContainer.backgroundColor = .systemBackground
        let widthContainer  = self.view.frame.width * 0.9
        let heightContainer  = self.view.frame.height / 2
        
        viewContainer.heightAnchor.constraint(equalToConstant: heightContainer).isActive = true
        viewContainer.widthAnchor.constraint(equalToConstant: widthContainer).isActive = true
        
        viewContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        viewContainer.addSubview(tableViewVariants)
        tableViewVariants.anchor( top: self.viewContainer.topAnchor, left:  self.viewContainer.leadingAnchor, right:  self.viewContainer.trailingAnchor, bottom: self.viewContainer.bottomAnchor, paddingTop: 20, paddingLeft: 10 ,paddingRight: -10, paddingBottom: 0, width: nil, height: nil)
        
        
      
        
        

  
        
        
        
        
        
        
        
    }
    
    
    // MARK: - IBActions
    // Here you add all your @IBActions (functions called by UI interactions like button taps)
    @objc func handleAddVariant(){
        print("Add Variant")

        // If there's a predecessor variant, check its name and options
        if let lastVariant = variants.last, lastVariant.name == nil || lastVariant.options.isEmpty {
            print("Predecessor Variant is missing a name or option.")
            return
        }
        
        print("Before \(variants.count)")
        // Append a new variant to the variants array.
        variants.append(Variant(name: nil, options: []))
        
        // Calculate the index path of the new row.
        print(variants)
        print(variants.count)
      
        let newIndexPath = IndexPath(row: variants.count - 1, section: 0)
        
        // Animate the insertion of the new row.
        tableViewVariants.beginUpdates()
        tableViewVariants.insertRows(at: [newIndexPath], with: .automatic)
        tableViewVariants.endUpdates()
        
        // Scroll to the newly added row at the bottom.
        tableViewVariants.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
    }
  
    
    // MARK: - Navigation
    // Segue preparations and related stuff
    
    // MARK: - Private methods
    // All other functions that you use within the ViewController
}

extension AddVariantController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  variants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: variantCellIdentifer, for: indexPath) as! VariantCell
        if (indexPath.row == 0){
            cell.isFirst = true
        }
        cell.selectionStyle = .none
        cell.delegate = self
        cell.variant = variants[indexPath.row]
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.systemBackground;
        } else {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.80);
        }
        
    
      
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           print("Deleted")
           self.variants.remove(at: indexPath.row)
           self.tableViewVariants.beginUpdates()
           self.tableViewVariants.deleteRows(at: [indexPath], with: .automatic)
           self.tableViewVariants.endUpdates()
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button  = CustomButton(title: "NEW VARIANT", hasBackground: true,  fontType: .medium)
        
        
        let button2  = CustomButton(title: "SAVE", hasBackground: true,  fontType: .medium)
        
        
        let button3  = CustomButton(title: "CANCEL", hasBackground: true,  fontType: .medium)
        
        let stackView =  StackManager.createStackView(with: [button2, button3], axis: .horizontal, spacing: 10, distribution: .fillEqually, alignment : .fill)
        
        
        let stackView2 = StackManager.createStackView(with: [button, stackView], axis: .vertical, spacing: 10, distribution: .fillEqually, alignment : .fill)
        
        
        
        
        
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.addSubview(stackView2)
        stackView2.anchor(top: view.topAnchor, left: view.leadingAnchor, right: view.trailingAnchor, bottom: view.bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: -10, paddingBottom: -10, width: nil, height: nil)
        
       
        
        
        button.addTarget(self, action: #selector(handleAddVariant), for: .touchUpInside)
        button2.addTarget(self, action: #selector(saveVariations), for: .touchUpInside)
        button3.addTarget(self, action: #selector(cancelVariations), for: .touchUpInside)
        
        
        
        return view
    }
//    func tableView(_ tableView: UITableView, viewHeaderIn  section: Int) -> UIView? {
//
//
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 75
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 100
//    }
    
    @objc func cancelVariations(){
        
        //RESET ALL THE VARIATIONS
        self.dismiss(animated: true)
        
        
        
    }
    @objc func saveVariations(){
        let validVariants = variants.filter { $0.name != nil }
          
        
        // Notify the delegate if there are valid variants.
        if !validVariants.isEmpty {
            delegate?.saveNewVariation(variantsArray: validVariants)
        }
            
        //RESET ALL THE VARIATIONS
        self.dismiss(animated: true)
        
        
        
    }
    
    
  
    
}

extension AddVariantController: VariantCellDelegate {
    func variantCell(_ cell: VariantCell, didUpdateVariant variant: Variant) {
        print(variant)
       
            
            // Assuming you have a reference to your tableView
            if let indexPath = tableViewVariants.indexPath(for: cell) {
                // Replace the existing variant at that index with the new one
                variants[indexPath.row] = variant
                
                // Optionally, you can reload the tableview cell to reflect any changes
//                tableViewVariants.reloadRows(at: [indexPath], with: .fade)
            }
            print(variants)
        }
        
    
    func cellDidBeginEditing(_ cell: VariantCell) {
        if let indexPath = tableViewVariants.indexPath(for: cell) {
            UIView.setAnimationsEnabled(false)
            tableViewVariants.beginUpdates()
            tableViewVariants.endUpdates()
            UIView.setAnimationsEnabled(true)
            tableViewVariants.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

    





//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//
//        if textView.text == "Enter your review " {
//            textView.text = ""
//            textView.textColor = .black
//        }
//
//    }
   
    

    
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        if textView.text.isEmpty {
//            textView.text = "Enter your review "
//            textView.textColor = .lightGray
//        }
//
//
//        textView.resignFirstResponder()
//        return true
//    }
    
    

