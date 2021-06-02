//
//  ReviewCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/24/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class ReviewCell: UICollectionViewCell {
    
    //MARK: - Vars
    let titleLabel = UILabel(text: "ReviewTitle", font: .boldSystemFont(ofSize: 18), numberOfLines: 0)
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16), numberOfLines: 0)
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    let bodyLabel = UILabel(text: "Main review Body", font: .systemFont(ofSize: 16), numberOfLines: 7)
    let starsStackView: UIStackView = {
        var arrangedSubViews = [UIView]()
        (0..<5).forEach { (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 20)
            imageView.constrainHeight(constant: 20)
            arrangedSubViews.append(imageView)
        }
        arrangedSubViews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedSubViews)
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8),
            starsStackView,
            bodyLabel
        ], spacing: 11)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
