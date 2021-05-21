//
//  APIService.swift
//  AppStoreJSONApis
//
//  Created by Mostafa Zidan on 5/18/21.
//  Copyright © 2021 Mostafa Zidan. All rights reserved.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    
    //MARK: - Fetching Apps
    func fetchApps(searchTerm: String = "instagram", completion: @escaping ([Result], Error?) -> Void) {
        let appsUrlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: appsUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch apps: ", err)
                completion([], err)
                return
            }
            
            
            //Succsess
            guard let data = data else {return}
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results, nil)
                
            } catch let error {
                completion([], error)
            }
        }.resume()
    }
    
    
    //MARK: - Fetching Top Grossing
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    
    //MARK: - Fetching Games
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    
    
    //MARK: - Helper Function
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        guard let gamesUrl = URL(string: urlString)
            else {return}
        URLSession.shared.dataTask(with: gamesUrl) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            //Decoding Data with JSON Decoder
            guard let data = data else {return}
            do {
                let appGroups = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(appGroups, nil)
            } catch let error {
                completion(nil, error)
            }
            
        }.resume()
    }
    
    
    //MARK: - Fetching Social Data
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            
            //Decoding Data with JSON Decoder
            guard let data = data else {return}
            do {
                let socialApps = try JSONDecoder().decode([SocialApp].self, from: data)
                completion(socialApps, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}
