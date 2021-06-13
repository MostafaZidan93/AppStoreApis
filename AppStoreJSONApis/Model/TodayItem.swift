//
//  TodayItem.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 6/2/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import UIKit


struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    let feedResults: [FeedResult]
    
    let cellType: CellType
    
    enum CellType: String {
        case single
        case multiple
    }
}
