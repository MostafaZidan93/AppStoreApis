//
//  SearchResultCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/18/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
 
    //MARK: - Vars
    var appResult: Result! {
        didSet {
            //Setting up labels
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
            
            
            //Fetching images
            appIconImageView.sd_setImage(with: URL(string: appResult.artworkUrl100),  completed: nil)
            screenShot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]), completed: nil)
            if appResult.screenshotUrls.count > 1 {
                screenShot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]), completed: nil)
            }
            if appResult.screenshotUrls.count > 2 {
                screenShot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]), completed: nil)
            }
        }
    }
    
    
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        return iv
    }()
    
    
    //Name Label
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        return label
    }()
    
    //Category Label
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "multimedia"
        return label
    }()
    
    //RatingLabel
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "100ff"
        return label
    }()
    
    
    let getButton: UIButton = {
        let button = UIButton()
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 12
        return button
    }()
    
    
    //Create screen shots
    lazy var screenShot1ImageView = createScreenShotImageView()
    lazy var screenShot2ImageView = createScreenShotImageView()
    lazy var screenShot3ImageView = createScreenShotImageView()
    func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        
        //Labels StackView
        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel])
        
        
        //Info Top Stack View
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        
        //Screen Shots Stack View
        let screenShotsStackView = UIStackView(arrangedSubviews: [screenShot1ImageView, screenShot2ImageView, screenShot3ImageView])
        screenShotsStackView.spacing = 12
        screenShotsStackView.distribution = .fillEqually
        
        
        //Overall Stack view
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenShotsStackView], spacing: 12)
        self.addSubview(overallStackView)
        
        //Auto Layout
        overallStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
