//
//  AppsHorizontalController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/19/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppsHorizontalController: BaseListController {
    
    //Vars
    var appGroup: AppGroup? {
        didSet {
            collectionView.reloadData()
        }
    }
    private let cellId = "id1"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    
    //MARK: - CollectionView Data Source Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        let app = appGroup?.feed.results[indexPath.item]
        cell.companyLabel.text = app?.artistName
        cell.nameLabel.text = app?.name
        cell.imageView.sd_setImage(with: URL(string: app!.artworkUrl100), completed: nil)
        
        return cell
    }
    
    
    //MARK: - CollectionView FLow Layout Delegate Methods
    
    private let topBottomPadding: CGFloat = 10
    private let lineSpacing: CGFloat = 10
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height )
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 16, bottom: 10, right: 16)
    }
}
