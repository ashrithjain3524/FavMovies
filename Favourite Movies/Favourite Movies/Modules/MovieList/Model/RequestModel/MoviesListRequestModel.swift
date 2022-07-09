//
//  MoviesListRequestModel.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class MoviesListRequestModel:RequestModel{
    var page:Int
    
     init(page:Int) {
         self.page = page
     }
    
     override var path: String{
        return Constant.API.movies(page: page).getRawValue()
     }
}
