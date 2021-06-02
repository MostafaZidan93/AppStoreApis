//
//  TodayCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/25/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class TodayCell: UICollectionViewCell {
    
    //MARK: - Vars
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
