//
//  MovieStore+CoreDataClass.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 10/07/22.
//
//

import Foundation
import CoreData

@objc(MovieStore)
public class MovieStore: NSManagedObject {
    
    func getMovieObject()->Movie{
        var movie = Movie()
        movie.id = Int(id)
        movie.title = title
        movie.rating = rating
        movie.poster = imagePath
        movie.releaseDate = releaseDate
        movie.overview = about
        movie.duration = Int(duration)
        return movie
    }
    
    func setMovieObject(movie:Movie){
        id = Int64(movie.id ?? 0)
        title = movie.title
        rating = movie.rating ?? 0.0
        imagePath = movie.poster
        releaseDate = movie.releaseDate
        about = movie.overview
        duration = Int64(movie.duration ?? 0)
    }
    
}
