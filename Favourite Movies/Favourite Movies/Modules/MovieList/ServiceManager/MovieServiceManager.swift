//
//  MovieServiceManager.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

protocol MovieServiceManagerDelegate {
    func fetchMovieList(requestModel:MoviesListRequestModel,completion:@escaping (Result<MovieList,ErrorModel>)->Void)
}

protocol MovieDetailsServiceManagerDelegate {
    func fetchMovieDetail(requestModel:MovieDetailRequestModel,completion:@escaping (Result<Movie,ErrorModel>)->Void)
}

class MovieServiceManager:MovieServiceManagerDelegate{
    
    func fetchMovieList(requestModel:MoviesListRequestModel,completion:@escaping (Result<MovieList,ErrorModel>)->Void) {
        let request = requestModel.urlRequest()
        NetworkManager().fetchRequest(type: MovieList.self, url: request, completion: completion)
    }
}

extension MovieServiceManager:MovieDetailsServiceManagerDelegate{
    func fetchMovieDetail(requestModel:MovieDetailRequestModel,completion:@escaping (Result<Movie,ErrorModel>)->Void) {
        let request = requestModel.urlRequest()
        NetworkManager().fetchRequest(type: Movie.self, url: request, completion: completion)
    }
}
