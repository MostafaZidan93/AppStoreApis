//
//  MultipleAppCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 6/12/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit
import SDWebImage

class MultipleAppCell: UICollectionViewCell {
    
    //MARK: - Vars
    var app: FeedResult! {
        didSet {
            self.nameLabel.text = app.name
            self.companyLabel.text = app.artistName
            self.imageView.sd_setImage(with: URL(string: app.artworkUrl100), completed: nil)
        }
    }
    let imageView = UIImageView(cornerRadius: 8)
    let getButton = UIButton(title: "GET")
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 16))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 12))
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32/2
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.backgroundColor = .yellow
            
        
        let stackView = UIStackView(arrangedSubviews: [imageView,VerticalStackView(arrangedSubviews: [nameLabel, companyLabel]) ,getButton])
        addSubview(stackView)
        stackView.fillSuperview()
        stackView.spacing = 16
        stackView.alignment = .center
        
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: -8, right: 0) , size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
