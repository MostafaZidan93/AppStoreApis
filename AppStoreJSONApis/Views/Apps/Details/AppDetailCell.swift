//
//  AppDetailCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/22/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppDetailCell: UICollectionViewCell {
    
    //MARK: - Vars
    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 20), numberOfLines: 2)
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 18))
    let releaseNotesLabel = UILabel(text: "ReleaseNotes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    var app: Result! {
        didSet {
            nameLabel.text = app?.trackName
            priceButton.setTitle(app?.formattedPrice, for: .normal)
            releaseNotesLabel.text = app?.releaseNotes
            whatsNewLabel.text = app?.description
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //App Icon Image
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        
        //Price Button
        priceButton.backgroundColor = #colorLiteral(red: 0.01451382786, green: 0.4745178223, blue: 0.9860290885, alpha: 1)
        priceButton.constrainHeight(constant: 32)
        priceButton.constrainWidth(constant: 80)
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.layer.cornerRadius = 32 / 2
        
        
        //Release Notes Label
        releaseNotesLabel.numberOfLines = 0
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [nameLabel, UIStackView(arrangedSubviews: [priceButton, UIView()]), UIView()], spacing: 12)], customSpacing: 20),
            whatsNewLabel,
            releaseNotesLabel], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
