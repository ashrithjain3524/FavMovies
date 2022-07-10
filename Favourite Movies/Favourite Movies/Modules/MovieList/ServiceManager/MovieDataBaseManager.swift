//
//  MovieDataBaseManager.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 10/07/22.
//

import Foundation

class MovieDataBaseManager:MovieServiceManagerDelegate {
    
    func fetchMovieList(requestModel: MoviesListRequestModel, completion: @escaping (Result<MovieList, ErrorModel>) -> Void) {
        let objects = PersistanceService.shared.fetch(MovieStore.self)
        var movies:[Movie] = []
        
        for obj in objects{
            movies.append(obj.getMovieObject())
        }
        var movieList = MovieList()
        movieList.results = movies
        completion(.success(movieList))
    }
    
}
