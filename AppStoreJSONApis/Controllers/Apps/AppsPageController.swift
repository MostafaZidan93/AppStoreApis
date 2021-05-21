//
//  AppsController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/19/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppsPageController: BaseListController {
    //Vars
    private let cellId = "id"
    private let headerId = "headerId"
    var editorsChoiceGames: AppGroup?
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        //Registering a header
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        //Fetching Data
        fetchData()
    }
    
    
    fileprivate func fetchData() {
        APIService.shared.fetchGames { (appGroups, error) in
            if let error = error {
                print("Error Feching data: ", error)
                return
            } else {
                self.editorsChoiceGames = appGroups
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    //MARK: - CollectionView DataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        
        cell.titleLabel.text = editorsChoiceGames?.feed.title
        cell.horizontalController.appGroup = editorsChoiceGames
        
        
        return cell
    }
    
    
    //Generating Upper Header Supplementary View
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    
    //MARK: - CollectionView Flow Layout Delegate Method
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}


