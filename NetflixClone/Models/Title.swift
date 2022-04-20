//
//  Movie.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 20.04.2022.
//

import Foundation

struct TrendingTitleResponse : Codable{
    let results : [Title]
}

struct Title : Codable {
    //API deki JSon ile aynı olmalılar
    let id : Int
    let media_type : String?
    let original_name : String?
    let original_title : String?
    let poster_path : String?
    let overview : String?
    let vote_count : Int
    let release_date : String?
    let vote_average : Double

}
