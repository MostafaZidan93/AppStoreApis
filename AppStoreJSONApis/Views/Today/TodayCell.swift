//
//  TodayCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/25/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class TodayCell: BaseTodayCell {
    
    //MARK: - Vars
    var topConstraint: NSLayoutConstraint!
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            descriptionLabel.text = todayItem.description
            imageView.image = todayItem.image
            self.backgroundColor = todayItem.backgroundColor
        }
    }
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        
        
        //Image Container View
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel,titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        
        
        //Adding Subview
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
//        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
