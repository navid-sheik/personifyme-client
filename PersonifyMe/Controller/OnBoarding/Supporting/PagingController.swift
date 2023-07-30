//
//  PagingController.swift
//  PersonifyMe
//
//  Created by Navid Sheikh on 29/07/2023.


import Foundation
import UIKit

class PaginController: UICollectionViewController {
    
    
    
    
    
    
    var pageArray  =  [PageModel(titleName: "This is the first title that  I should use",
                                 descriptionName: "This character description generator will generate a fairly random description of a belonging to a random race. However, some aspects of the descriptions will remain the same, this is done to keep the general structure the same, while still randomizing the important details.",
                                 imageString: "logo"),
    PageModel(titleName: "Kami",
    descriptionName: "The c does take into account which race is randomly picked, and changes some of the details accordingly. For example, if the character is an elf, they will have a higher chance of looking good and clean.",
    imageString: "logo"),

    PageModel(titleName: "Dave",
    descriptionName: "I've made the descriptions as detailed as possible, while also withholding as many details as possible. This may sound odd, but I've done it by mostly describing how a character looks, rather than his or her personality. I've tried to make the character's looks and some vague personality traits dictate what kind of person he or she could be.",
    imageString: "logo")
    ]
    
    
    let identifier  = "identifier"
    
    let buttonNext : UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    
    
    let buttonPrev : UIButton = {
        let button =  UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    
    lazy var pagingController : UIPageControl = {
        let pageControl =  UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageArray.count
        pageControl.tintColor =  .blue
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        navigationController?.isNavigationBarHidden = true
        
        setBottomController()
        
    
    }
    
   
    
    
    private func setBottomController (){
        buttonNext.addTarget(self, action: #selector(hadleNext), for: .touchUpInside)
        buttonPrev.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        let bottomStackView  = UIStackView(arrangedSubviews: [buttonPrev, pagingController, buttonNext])
        bottomStackView.alignment = .fill
        bottomStackView.axis =  .horizontal
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.addSubview(bottomStackView)
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    @objc func hadleNext(){
        print("Going to the next")
        //Min ensure that the current page doesn't of index
        let nextPath = min(pagingController.currentPage + 1, pageArray.count - 1)
        let indexPath = IndexPath(item: nextPath, section: 0)
        pagingController.currentPage = nextPath
        collectionView.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true)
    }
    
    @objc func handlePrev(){
        print("Going to the prev")
        let nextPath = max(pagingController.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextPath, section: 0)
        pagingController.currentPage = nextPath
        collectionView.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true)
    }
    
    
}

extension PaginController : UICollectionViewDelegateFlowLayout{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PageCell
        cell.pageModel =  pageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension PaginController{
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x  =  targetContentOffset.pointee.x
        pagingController.currentPage = Int(x /  view.frame.width)
    }
}
