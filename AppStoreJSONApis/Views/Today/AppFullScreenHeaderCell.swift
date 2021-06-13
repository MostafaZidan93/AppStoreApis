//
//  AppFullScreenHeaderCell.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/28/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


class AppFullScreenHeaderCell: UITableViewCell {
    
    //MARK: - Vars
    let todayCell = TodayCell()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Today Cell
        addSubview(todayCell)
        todayCell.fillSuperview()
        
        //Close Button
        addSubview(closeButton)
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
