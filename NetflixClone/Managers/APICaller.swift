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
    
    
    // istenilen kategoriye ait istek atmak için
    func getTrendingMovies(completition: @escaping (Result<[Title],Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)3/trending/movie/day?api_key=\(Constants.API_Key)") else {return}
        // istek atılıp results un döndügü yer
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completition(.success(results.results))
            }catch{
                completition(.failure(APIError.failedTogetData))
            }
            
        }
        task.resume()
    }
    
    func getTrendingTVs(completition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/trending/tv/day?api_key=\(Constants.API_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completition(.success(results.results))
            }catch{
                completition(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovie(completition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/movie/upcoming?api_key=\(Constants.API_Key)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completition(.success(results.results))
            }catch{
                completition(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    func getPopular(completition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/movie/popular?api_key=\(Constants.API_Key)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completition(.success(results.results))
            }catch{
                completition(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    func getTopRated(completition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/movie/top_rated?api_key=\(Constants.API_Key)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completition(.success(results.results))
            }catch{
                completition(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
 
