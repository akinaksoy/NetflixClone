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
    static let youtubeAPI_Key = "AIzaSyA73SwgcbIKRDEJKoMeV-JiQOO1leNUL7I"
    static let youtubeBase_URL = "https://youtube.googleapis.com/youtube"
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
    
    
    func getDiscoverMovies(completition: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/discover/movie?api_key=\(Constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
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
    
    func searchQuery(with query: String, completition: @escaping (Result<[Title],Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return}
        
        guard let url = URL(string: "\(Constants.baseURL)3/search/movie?api_key=\(Constants.API_Key)&query=\(query)") else {return}
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
    
    
    func getYoutubeVideo(with query : String, completition: @escaping (Result<VideoElement,Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return}
        guard let url = URL(string: "\(Constants.youtubeBase_URL)/v3/search?q=\(query)&key=\(Constants.youtubeAPI_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completition(.success(results.items[0]))
            }catch{
                completition(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
}
 
