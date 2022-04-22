//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 22.04.2022.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items : [VideoElement]
}

struct VideoElement : Codable {
    let id: IdVideoElement
}

struct IdVideoElement : Codable {
    let kind: String
    let videoId : String
}

/* Ornek API Response
 items =     (
             {
         etag = "09YTY3U_a09sR7aIKQpXJC5SuPs";
         id =             {
             kind = "youtube#video";
             videoId = tqDbYqPn7Ho;
         };
         kind = "youtube#searchResult";
     },
 */
