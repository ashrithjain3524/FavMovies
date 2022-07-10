//
//  MovieDetailRequestModel.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 10/07/22.
//

import Foundation

class MovieDetailRequestModel:RequestModel{
    var movieId:Int
    
     init(movieId:Int) {
         self.movieId = movieId
     }
    
     override var path: String{
        return Constant.API.movieDetail(id: movieId).getRawValue()
     }
}
