//
//  MovieServiceManager.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

protocol MovieServiceManagerDelegate {
    func fetchPopularNews(requestModel:MoviesListRequestModel,completion:@escaping (Result<MovieList,ErrorModel>)->Void)
}

class MovieServiceManager:MovieServiceManagerDelegate{
    
    func fetchPopularNews(requestModel:MoviesListRequestModel,completion:@escaping (Result<MovieList,ErrorModel>)->Void) {
        let request = requestModel.urlRequest()
        NetworkManager().fetchRequest(type: MovieList.self, url: request, completion: completion)
    }
}
