//
//  AppsController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/19/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppsPageController: BaseListController {
    
    
    //MARK: - Vars
    private let cellId = "id"
    private let headerId = "headerId"
    var groups = [AppGroup]()
    var socialApps = [SocialApp]()
    let activityIndecator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        aiv.color = .darkGray
        
        return aiv
    }()
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        //Registering a header
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        //Activity Indecator
        view.addSubview(activityIndecator)
        activityIndecator.fillSuperview()
        
        
        //Fetching Data
        fetchData()
    }
    
    
    fileprivate func fetchData() {
        
        //Dispatch Group
        let dispatchGroup = DispatchGroup()
        
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        
        //Fetching Social Apps
        dispatchGroup.enter()
        APIService.shared.fetchSocialApps { (apps, error) in
            dispatchGroup.leave()
            if let error = error {
                print("Error Fetching Social Apps: ", error)
                return
            }
            guard let apps = apps else {return}
            self.socialApps = apps
        }
        
        
        dispatchGroup.enter()
        APIService.shared.fetchGames { (appGroup, error) in
            dispatchGroup.leave()
            group1 = appGroup
        }
        
        
        dispatchGroup.enter()
        APIService.shared.fetchTopGrossing { (appGroup, error) in
            dispatchGroup.leave()
            group2 = appGroup
        }
        
        
        dispatchGroup.enter()
        APIService.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json") { (appGroup, error) in
            dispatchGroup.leave()
            group3 = appGroup
        }
        
        
        dispatchGroup.notify(queue: .main) {
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
            self.activityIndecator.stopAnimating()
        }
    }
    
    
    //MARK: - CollectionView DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        
        cell.titleLabel.text = groups[indexPath.item].feed.title
        cell.horizontalController.appGroup = groups[indexPath.item]
        cell.horizontalController.didSelectHandler = { [weak self]feedResult in
            let detailViewController = AppDetailController()
            detailViewController.navigationItem.title = feedResult.name
            detailViewController.appId = feedResult.id
            
            self?.navigationController?.pushViewController(detailViewController, animated: true)
        }
        return cell
    }
    
    
    //Generating Upper Header Supplementary View
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.socialApps = socialApps
        return header
    }
    
    
    
    //MARK: - CollectionView Flow Layout Delegate Method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}


