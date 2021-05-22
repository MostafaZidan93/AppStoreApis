//
//  AppDetailController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/22/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppDetailController: BaseListController {
    let detailCellId = "detailCellId"
    var appId: String! {
        didSet {
            print("Here is my id: ", appId as Any)
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            APIService.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
                guard let res = result else {return}
                print("New Test: ", res.results.first?.releaseNotes as Any)
                print("New Test name: ", res.results.first?.trackName as Any)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
    }

    
    //MARK: - CollectionView DataSource Methods
    //Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    //Cell For item at indexPath
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
            
        return cell
    }
    
    
    //MARK: - CollectionView Flow Delegate Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }

}

