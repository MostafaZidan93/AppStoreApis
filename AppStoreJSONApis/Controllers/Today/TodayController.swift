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
    static let cellSize: CGFloat = 500
    var appFullScreenController: AppFullScreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var topGrossingGroup: AppGroup?
    var gamesGroup: AppGroup?
    var backenabledNavBar: BackEnabledNavigationController?
    let activityIndecatiorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.backgroundColor = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
//    let items = [TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything.", backgroundColor: #colorLiteral(red: 0.9817447066, green: 0.9296296239, blue: 0.7017626166, alpha: 1), cellType: .single), TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive CarPlay Apps", image: #imageLiteral(resourceName: "star"), description: "", backgroundColor: .white, cellType: .multiple)]
    var items = [TodayItem]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndecatiorView)
        activityIndecatiorView.centerInSuperview()
        fetchData()
        collectionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    
    //View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        APIService.shared.fetchTopGrossing { (appGroup, err) in
            guard let appGroup = appGroup else {return}
            self.topGrossingGroup = appGroup
            
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.enter()
        APIService.shared.fetchGames { (appGroup, err) in
            guard let appGroup = appGroup else {return}
            self.gamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) {
            self.items = [TodayItem.init(category: "Daily List", title: self.topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "star"), description: "", backgroundColor: .white, feedResults: self.topGrossingGroup?.feed.results ?? [], cellType: .multiple), TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, feedResults: [], cellType: .single), TodayItem.init(category: "Daily List", title: self.gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "star"), description: "", backgroundColor: .white, feedResults: self.gamesGroup?.feed.results ?? [], cellType: .multiple)]
            self.collectionView.reloadData()
            self.activityIndecatiorView.stopAnimating()
        }
    }
    
    
    //MARK: - CollectionView Data Source Methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        (cell as? TodayMultipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        return cell
        //        if indexPath.item == 0 {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mulCellId, for: indexPath) as! TodayMultipleAppCell
        //            cell.todayItem = items[indexPath.item]
        //            return cell
        //        }
        //
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TodayCell
        //        cell.todayItem = items[indexPath.item]
        //        return cell
    }
    @objc private func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        
        //Figure out which cell we click into
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else {return}
                let apps = self.items[indexPath.item].feedResults
                let fullController = TodayMultipleAppsController(mode: .fullScreen)
                fullController.results = apps
                self.navigationController?.pushViewController(fullController, animated: true)
                return
            }
            superView = superView?.superview
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    //MARK: - CollectionView Delegate FLow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    
    //MARK: - CollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if items[indexPath.item].cellType == .multiple {
            let fullController = TodayMultipleAppsController(mode: .fullScreen)
            fullController.results = self.items[indexPath.item].feedResults
            self.navigationController?.pushViewController(fullController, animated: true)
            return
        }
        
        
        let appFullScreenController = AppFullScreenController()
        appFullScreenController.todayItem = items[indexPath.item]
        appFullScreenController.dismisHandler = {
            self.screenTapped()
        }
        let fullScreenView = appFullScreenController.view!
        self.appFullScreenController = appFullScreenController
        addChild(appFullScreenController)
        self.collectionView.isUserInteractionEnabled = false
        guard let cell = collectionView.cellForItem(at: indexPath) else { return  }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        
        
        //        redView.frame = startingFrame
        self.startingFrame = startingFrame
        fullScreenView.layer.cornerRadius = 16
        view.addSubview(fullScreenView)
        //AutoLayout constraint animations
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
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
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else {return}
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
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
            
            
//            self.tabBarController?.tabBar.transform = .identity
            self.tabBarController?.tabBar.isHidden = false
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else {return}
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
        }, completion: { _ in
            //            gesture.view?.removeFromSuperview()
            self.appFullScreenController.view.removeFromSuperview()
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}
