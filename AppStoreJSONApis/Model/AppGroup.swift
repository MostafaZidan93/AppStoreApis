//
//  AppGroup.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/19/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import Foundation



struct AppGroup: Decodable {
    
    let feed: Feed
}


struct Feed: Decodable {
    
    let title: String
    let results: [FeedResult]
}


struct FeedResult: Decodable {
    let name: String
    let artistName: String
    let artworkUrl100: String
    let id: String
}
