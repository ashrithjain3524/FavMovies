//
//  MovieDetailViewModel.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {
    let serviceHandler:MovieDetailsServiceManagerDelegate
    var responseObject:Movie?
    var movie:Movie
    
    init(serviceHandler:MovieDetailsServiceManagerDelegate = MovieServiceManager(),movie:Movie) {
        self.movie = movie
        self.serviceHandler = serviceHandler
    }
    
    func fetchDetails(id:Int){
        let requestModel = MovieDetailRequestModel(movieId: id)
        self.showActivity.value = true
        let isConnected = InternetConnectionManager.isConnectedToNetwork()
        print("isConnected = \(isConnected)")
        serviceHandler.fetchMovieDetail(requestModel: requestModel) { [weak self] (result) in
            self?.showActivity.value = false
            switch result {
            case .success(let model):
                self?.responseObject = model
                self?.movie = model
                self?.reloadTable.value = true
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
}
