//
//  APICaller.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 20.04.2022.
//

import Foundation

struct Constants {
    static let API_Key = "4e9def48a480fb4637caf940fa06f212"
    static let baseURL = "https://api.themoviedb.org/"
}


class APICaller {
    static let shared = APICaller()
    
    
    
    func getTrendingMovies(completition: @escaping (String) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
                print(result)
            }catch{
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
