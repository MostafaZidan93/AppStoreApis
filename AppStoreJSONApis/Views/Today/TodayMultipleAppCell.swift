//
//  TodayMultipleAppCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 6/12/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class TodayMultipleAppCell: BaseTodayCell {
    
    //MARK: - Vars
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    let multipleAppsController = TodayMultipleAppsController(mode: .small)
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            multipleAppsController.results = todayItem.feedResults
            multipleAppsController.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 16
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, multipleAppsController.view], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
