//
//  MovieListingViewModel.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class MovieListingViewModel: BaseViewModel {
    let serviceHandler:MovieServiceManagerDelegate
    let dataBaseHandler:MovieServiceManagerDelegate
    var responseObject:MovieList?
    var movieList:[Movie] = []
    var errorPop:Bindable<ErrorModel> = Bindable(ErrorModel.NoInterNet)
    init(serviceHandler:MovieServiceManagerDelegate = MovieServiceManager(),dataBaseHandler:MovieServiceManagerDelegate = MovieDataBaseManager()) {
        self.serviceHandler = serviceHandler
        self.dataBaseHandler = dataBaseHandler
    }
    
    func fetchMovieList(page:Int) {
        let requestModel = MoviesListRequestModel(page: page)
        self.showActivity.value = true
        let isConnected = InternetConnectionManager.isConnectedToNetwork()
        let handler = isConnected ? serviceHandler : dataBaseHandler
        handler.fetchMovieList(requestModel: requestModel) { [weak self] (result) in
            self?.showActivity.value = false
            switch result {
            case .success(let model):
                self?.responseObject = model
                if let movies = model.results{
                    self?.movieList = movies
                    if isConnected{
                        self?.deleteAllFromCoreData()
                        self?.saveMoviesCoreData(movies: movies)
                    }
                }
                self?.reloadTable.value = true
            case .failure(let error):
                print(error)
                self?.errorPop.value = error
            }
        }
        
        if !isConnected{
            errorPop.value = .NoInterNet
            
        }
    }
    
    private func deleteAllFromCoreData() {
        let objects = PersistanceService.shared.fetch(MovieStore.self)
        
        for obj in objects{
            PersistanceService.shared.delete(obj)
        }
        
        PersistanceService.shared.saveContext()
    }
    
    private  func saveMoviesCoreData(movies:[Movie]) {
        var store = MovieStore(context:PersistanceService.shared.context)
        for obj in movies{
            store = MovieStore(context:PersistanceService.shared.context)
            store.setMovieObject(movie: obj)
            PersistanceService.shared.saveContext()
        }
        
    }
    
}
