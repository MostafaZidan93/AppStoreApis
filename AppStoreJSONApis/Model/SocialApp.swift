//
//  SocialApp.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/21/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import Foundation


struct SocialApp: Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let tagline: String
}
