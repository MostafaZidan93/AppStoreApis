//
//  PreviewCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/24/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class PreviewCell: UICollectionViewCell {
    
    let horizontalController = PreviewScreenShotsController()
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 30))
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewLabel)
        addSubview(horizontalController.view)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        horizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 8))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
