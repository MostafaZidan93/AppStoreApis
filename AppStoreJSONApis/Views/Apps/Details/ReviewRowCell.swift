//
//  ReviewRowCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/24/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    //MARK: - Vars
    let horizontalReviewController = HorizontalReviewController()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addSubview(horizontalReviewController.view)
        horizontalReviewController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
