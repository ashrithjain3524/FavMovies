//
//  MovieDetails.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 10/07/22.
//

import Foundation

struct Movie:Codable {
    var id:Int?
    var mediaType:String?
    var title:String?
    var rating:Double?
    var poster:String?
    var genres:[Generes]?
    var duration:Int?
    var releaseDate:String?
    var languages:[Languages]?
    var overview:String?
    var votes:Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case title
        case rating = "vote_average"
        case poster = "poster_path"
        case genres
        case duration = "runtime"
        case releaseDate = "release_date"
        case languages = "spoken_languages"
        case overview
        case votes = "vote_count"
    }
    
    func getDuration()->String{
        let duration = self.duration ?? 0
        let hours = Int(duration / 60)
        let minutes = duration % 60
        return "\(hours) hours \(minutes) mins"
    }
    
    func getReleaseDate()->String{
        let dateString = releaseDate ?? ""
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-mm-dd"
        let date = formater.date(from: dateString)
        formater.dateFormat = "MMM dd,yyyy"
        
        
        return formater.string(from: date ?? Date())
    }
    
    func getLanguages()->String{
        let language = languages ?? []
        var outPutString = ""
        outPutString.append("Languages: ")
        for obj in 0..<language.count{
            outPutString.append(language[obj].englishName ?? "")
            if obj < language.count - 1 {
                outPutString.append(", ")
            }
        }
        return outPutString
    }
    
}

struct Generes:Codable {
    var id:Int?
    var name:String?
    
}

struct Languages:Codable {
    var englishName:String?
    var iso:String?
    var name:String?
    private enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso = "iso_639_1"
        case name
    }
}
