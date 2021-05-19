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
    
    
    func fetchApps(searchTerm: String = "instagram", completion: @escaping ([Result], Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else {return}
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
                print("Error Decoding data: ", error)
                completion([], error)
            }
        }.resume()
    }
}
