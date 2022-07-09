//
//  API.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

extension Constant {
    static let BaseUrl: String = "https://api.themoviedb.org"
    static let APIKey: String = "a44e067afda6c1cf762870050136866f"
    static let ImageBaseUrl: String = "https://image.tmdb.org"
   // https://image.tmdb.org/t/p/w500/ocUp7DJBIc8VJgLEw1prcyK1dYv.jpg
    enum API{
        case movies(page:Int)
        case movieDetail(id:Int)
        case image(width:ImageWidth,path:String)
        func getRawValue()->String{
            switch self {
            case .movies(let page):
                var rawValue =  BaseAPI.movies.rawValue
                rawValue = rawValue + "/\(page)?api_key=\(Constant.APIKey)"
                return rawValue
            case .movieDetail(let id):
                var rawValue =  BaseAPI.movieDetail.rawValue
                rawValue = rawValue + "/\(id)/images?api_key=\(Constant.APIKey)"
                return rawValue
            case .image(let width,let path):
                var rawValue =  BaseAPI.image.rawValue
                rawValue = rawValue + "/\(width.rawValue)/\(path)"
                return rawValue
            }
        }
    }
    
    enum BaseAPI:String{
        case movies = "/4/list"
        case movieDetail = "/3/movie"
        case image = "/t/p"
    }
    
    enum ImageWidth:String {
        case w1 = "w92"
        case w2 = "w154"
        case w3 = "w185"
        case w4 = "w342"
        case w5 = "w500"
        case w6 = "w780"
        case original = "original"
        
    }
    
}
