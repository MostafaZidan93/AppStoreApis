//
//  TodayController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/25/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class TodayController: BaseListController {
    
    //MARK: - Vars
    let cellId = "todayCellId"
    var appFullScreenController: AppFullScreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    //View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: - CollectionView Data Source Methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    //MARK: - CollectionView Delegate FLow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 500)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    
    //MARK: - CollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullScreenController = AppFullScreenController()
        appFullScreenController.dismisHandler = {
            self.screenTapped()
        }
        let redView = appFullScreenController.view!
        self.appFullScreenController = appFullScreenController
        addChild(appFullScreenController)
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(screenTapped)))
        guard let cell = collectionView.cellForItem(at: indexPath) else { return  }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        
        
//        redView.frame = startingFrame
        self.startingFrame = startingFrame
        redView.layer.cornerRadius = 16
        view.addSubview(redView)
        //AutoLayout constraint animations
        redView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = redView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = redView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
            
        
        //Animation
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
            
            self.tabBarController?.tabBar.isHidden = true
        }, completion: nil)
    }
    
    
    //Selector Method
    var startingFrame: CGRect?
    @objc func screenTapped() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            //This is a bad frame code
//            gesture.view?.frame = self.startingFrame ?? .zero
            
            
            //Scroll to Top
            self.appFullScreenController.tableView.contentOffset = .zero
            
            
            //New frame Code
            guard let startingFrame = self.startingFrame else {return}
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            
            
            self.tabBarController?.tabBar.transform = .identity
        }, completion: { _ in
//            gesture.view?.removeFromSuperview()
            self.appFullScreenController.view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
        })
    }
}
