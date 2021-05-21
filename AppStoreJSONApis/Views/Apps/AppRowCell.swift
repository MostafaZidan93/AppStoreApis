//
//  AppRowCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/19/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    let getButton = UIButton(title: "GET")
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 16))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 12))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32/2
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
            
        
        let stackView = UIStackView(arrangedSubviews: [imageView,VerticalStackView(arrangedSubviews: [nameLabel, companyLabel]) ,getButton])
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.spacing = 16
        stackView.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
