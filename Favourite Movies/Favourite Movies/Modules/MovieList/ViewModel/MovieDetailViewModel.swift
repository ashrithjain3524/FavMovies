//
//  MovieDetailViewModel.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {
    let serviceHandler:MovieServiceManagerDelegate
    var movie:Movie
    
    init(serviceHandler:MovieServiceManagerDelegate = MovieServiceManager(),movie:Movie) {
        self.movie = movie
        self.serviceHandler = serviceHandler
    }

}
