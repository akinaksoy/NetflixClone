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

enum APIError : Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    
    
    func getTrendingMovies(completition: @escaping (Result<[Movie],Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completition(.success(results.results))
            }catch{
                completition(.failure(error))
            }
            
        }
        task.resume()
    }
}
