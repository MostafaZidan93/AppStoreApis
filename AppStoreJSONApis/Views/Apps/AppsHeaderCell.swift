//
//  AppsHeaderCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/19/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppsHeaderCell: UICollectionViewCell {
    
    //Vars
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Keeping Up with friends is fater than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        titleLabel.numberOfLines = 0
        companyLabel.textColor = .blue
        

        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
