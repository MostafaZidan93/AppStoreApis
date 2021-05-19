//
//  VerticalStackView.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/18/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedSubviews.forEach { addArrangedSubview($0)
        }
        self.axis = .vertical
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
