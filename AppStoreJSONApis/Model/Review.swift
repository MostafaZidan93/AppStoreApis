//
//  Review.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/24/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import Foundation


struct Reviews: Decodable {
    let feed: ReviewFeed
}


struct ReviewFeed: Decodable {
    let entry: [Entry]
}


struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
    let rating: Label
    
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case content
        case rating = "im:rating"
    }
}

struct Label: Decodable {
    let label: String
}

struct Author: Decodable {
    let name: Label
}
