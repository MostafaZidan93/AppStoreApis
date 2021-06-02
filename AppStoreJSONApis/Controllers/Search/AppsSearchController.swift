//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/18/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit
import SDWebImage


class AppsSearchController: BaseListController, UISearchBarDelegate {
    
    //MARK: - Vars
    fileprivate var appResults = [Result]()
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    fileprivate let cellId = "id1234"
    fileprivate var enterSearchTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search text above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        //Register a cell for collectionView
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        //Adding a label
        view.addSubview(enterSearchTextLabel)
        enterSearchTextLabel.fillSuperview()
        
        //Search Bar
        setupSearchBar()
    }
    
    
    //MARK: - Search Bar Setup
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        //searchController.dimsBackgroundDuringPresentation = false
        
        //Search bar delegate
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
            APIService.shared.fetchApps(searchTerm: searchText) { (res, error) in
                if let error = error {
                    print("Failed to Fetch apps: ", error)
                    return
                }
                
                self.appResults = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    //MARK: - URLSession Task
    fileprivate func fetchITunesApps() {
        APIService.shared.fetchApps { (res, error) in
            if let error = error {
                print("Failed to Fetch apps: ", error)
                return
            }
            
            self.appResults = res?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
       
    
    //MARK: - CollectionView DataSource
    
    //Cell for item at indexPath
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.appResult = appResults[indexPath.item]
        return cell
    }
    
    
    //Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTextLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    
    //MARK: - CollectionView Delegate Flow Layout
    // Size of each item at indexPath
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
    //MARK: - CollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appDetailVC = AppDetailController(appId: String(appResults[indexPath.item].trackId))
        navigationController?.pushViewController(appDetailVC, animated: true)
    }
}
