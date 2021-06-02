//
//  AppDetailController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/22/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppDetailController: BaseListController {
    
    //MARK: - Depenency constructor
    init(appId: String) {
        self.appId = appId
        super.init()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func fetchData() {
        //General app Details
        var urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        APIService.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
            guard let res = result else {return}
            self.app = res.results.first
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        //Review Details
        urlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        APIService.shared.fetchGenericJSONData(urlString: urlString) { (reviews: Reviews?, err) in
            if let error = err {
                print("Failed to fetch jason data", error)
                return
            }
            
            //Output Data
            reviews?.feed.entry.forEach({ (entry) in
                self.reviews = reviews
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
    }
    
    
    //MARK: -Vars
    let detailCellId = "detailCellId"
    let previewCellId = "previewCellId"
    let reviewCellId = "reviewRowCell"
    let appId: String
    var app: Result?
    var reviews: Reviews?
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        //Registering Multiple cells
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
    }
    
    
    //MARK: - CollectionView DataSource Methods
    //Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    //Cell For item at indexPath
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let detailsCell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            detailsCell.app = app
            return detailsCell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            
            cell.horizontalController.app = app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.horizontalReviewController.reviews = self.reviews
            return cell
        }
        
    }
    
    
    //MARK: - CollectionView Flow Delegate Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        if indexPath.item == 0 {
            //Creating Dummy Cell
            let dummyCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            height = estimatedSize.height
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 280
        }
        return .init(width: view.frame.width, height: height)
    }
    
    
    //Inset for sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
}

