//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/19/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit

//MARK: - UILabel Extension
extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}


//MARK: - UIImageView Extension
extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}


//MARK: - UIButton Extension
extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        
    }
}


//MARK: - UIStackView Extension
extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing:CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
