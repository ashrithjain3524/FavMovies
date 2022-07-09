//
//  MovieList.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

struct MovieList:Codable {
    var id:Int?
    var name:String?
    var results:[Movie]?
}

struct Movie:Codable {
    var id:Int?
    var mediaType:String?
    var title:String?
    var rating:Double?
    var poster:String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case title
        case rating = "vote_average"
        case poster = "poster_path"
    }
}
