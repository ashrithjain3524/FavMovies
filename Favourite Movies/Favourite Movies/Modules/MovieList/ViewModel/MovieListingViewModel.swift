//
//  MovieListingViewModel.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class MovieListingViewModel: BaseViewModel {
    let serviceHandler:MovieServiceManagerDelegate
    var responseObject:MovieList?
    var movieList:[Movie] = []
    
    init(serviceHandler:MovieServiceManagerDelegate = MovieServiceManager()) {
        self.serviceHandler = serviceHandler
    }

    func fetchMovieList(page:Int) {
        let requestModel = MoviesListRequestModel(page: page)
        self.showActivity.value = true
        serviceHandler.fetchPopularNews(requestModel: requestModel) { [weak self] (result) in
            self?.showActivity.value = false
            switch result {
            case .success(let model):
                self?.responseObject = model
                if let movies = model.results{
                    self?.movieList = movies
                }
                self?.reloadTable.value = true
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
