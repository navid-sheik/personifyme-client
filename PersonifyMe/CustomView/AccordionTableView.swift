//
//  AccordionViewController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 05/08/2023.
//

import Foundation
import UIKit



struct Section {
    var title: String
    var items: [String]
    var isExpanded: Bool = false
}

class AccordionTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var sections: [Section] = [] {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        delegate = self
        dataSource = self
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.setTitle(sections[section].title, for: .normal)
        button.backgroundColor = .systemGray
        button.tag = section
        button.addTarget(self, action: #selector(toggleSection), for: .touchUpInside)
        return button
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    @objc private func toggleSection(button: UIButton) {
        let section = button.tag
        sections[section].isExpanded.toggle()

        // Animate the expansion or collapse using a fade animation
        self.performBatchUpdates({
            self.reloadSections(IndexSet(integer: section), with: .fade)
        }, completion: nil)
    }
}


class ExpandableTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var sections: [Section] = []
    let kHeaderSectionTag: Int = 6900
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.tableFooterView = UIView() // Removes extra separators
        self.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSections(_ sections: [Section]) {
        self.sections = sections
        self.reloadData()
    }
    
    // UITableViewDelegate and UITableViewDataSource methods
    // ...
}

extension ExpandableTableView {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView()
        headerView.textLabel?.text = sections[section].title
        headerView.contentView.backgroundColor = UIColor.systemGreen
        headerView.textLabel?.textColor = UIColor.white

        let imageView = UIImageView(image: UIImage(systemName: sections[section].isExpanded ? "chevron.up" : "chevron.down"))
        imageView.frame = CGRect(x: self.frame.size.width - 32, y: 13, width: 18, height: 18)
        headerView.addSubview(imageView)
        
        headerView.tag = section
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderWasTouched(_:)))
        headerView.addGestureRecognizer(tapGesture)

        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    @objc private func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        sections[section].isExpanded.toggle()
        self.reloadSections([section], with: .automatic)
    }
    

}

class SectionCell: UITableViewCell {
    
    let chevronButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal) // Default image
        return button
    }()
    
    let textSection: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(textSection)
        contentView.addSubview(chevronButton)
        
        NSLayoutConstraint.activate([
            textSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textSection.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            chevronButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chevronButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronButton.widthAnchor.constraint(equalToConstant: 20),
            chevronButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func updateButtonImage(isExpanded: Bool, animated: Bool = true) {
        let imageName = isExpanded ? "chevron.up" : "chevron.down"
        let image = UIImage(systemName: imageName)
        
        if animated {
            UIView.transition(with: chevronButton,
                              duration: 0.3,
                              options: .transitionFlipFromTop,
                              animations: {
                                  self.chevronButton.setImage(image, for: .normal)
                              },
                              completion: nil)
        } else {
            chevronButton.setImage(image, for: .normal)
        }
    }
}

class TextViewCell: UITableViewCell {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.masksToBounds = true
        textView.text = "Great things"
        textView.textAlignment = .left
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextView() {
        contentView.addSubview(textView)
        textView.anchor( top: topAnchor, left: leadingAnchor, right: trailingAnchor, bottom: bottomAnchor, paddingTop: 0, paddingLeft: 0,paddingRight: 0, paddingBottom: 0, width: nil, height: nil)
    
       
    }
}

class ExpandableTableViewV2: DynamicTableView, UITableViewDelegate, UITableViewDataSource {

    var sections: [Section] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 100
        

      
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.register(TextViewCell.self, forCellReuseIdentifier: "textCell")
        self.register(SectionCell.self, forCellReuseIdentifier: "sectionCell")
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count + 1 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          if indexPath.row == 0 {
              
              let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath) as! SectionCell
            
              cell.textSection.text = sections[indexPath.section].title
//              sections[indexPath.section].isExpanded.toggle()
              cell.updateButtonImage(isExpanded: sections[indexPath.section].isExpanded)
              return cell
          } else {
              let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! TextViewCell
              cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
              cell.textView.text = sections[indexPath.section].items[indexPath.row - 1]
              return cell
          }
      }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            
            // Toggle the section's expanded state
                 sections[indexPath.section].isExpanded.toggle()

                 // Update the appearance of the selected cell
                 if let cell = tableView.cellForRow(at: indexPath) as? SectionCell {
                     cell.updateButtonImage(isExpanded: sections[indexPath.section].isExpanded)
                 }

                 // Prepare the index paths for the rows to be inserted or deleted
                 let rows = sections[indexPath.section].items.indices.map { IndexPath(row: $0 + 1, section: indexPath.section) }

                 // Animate the insertion or deletion of rows
                 tableView.performBatchUpdates({
                     if sections[indexPath.section].isExpanded {
                         tableView.insertRows(at: rows, with: .fade)
                     } else {
                         tableView.deleteRows(at: rows, with: .fade)
                     }
                 }, completion: nil)
        }
    }

    // Remove header and footer to remove space between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        
        }
        return 150
    }
    
    
}
