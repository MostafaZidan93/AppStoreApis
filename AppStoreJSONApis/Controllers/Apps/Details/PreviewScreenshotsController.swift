//
//  PreviewScreenshotsController.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/24/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class PreviewScreenShotsController: HorizontalSnappingController {
    
    //MARK: - Vars
    let cellId = "PreviewScreenShotsCellId"
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Custom Cell Class
    class ScreensShotCell: UICollectionViewCell {
        let imageView = UIImageView(cornerRadius: 12)
        override init(frame: CGRect) {
            super.init(frame: frame)
            imageView.backgroundColor = .purple
            addSubview(imageView)
            imageView.fillSuperview()
        }
        
        required init?(coder: NSCoder) {
            fatalError()
        }
    }
    
    
    
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ScreensShotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
    //MARK: - collectionView DataSource Methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreensShotCell
        cell.imageView.sd_setImage(with: URL(string: ((app?.screenshotUrls[indexPath.item])!)))
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    
    //MARK: - collectionView Delegate Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
