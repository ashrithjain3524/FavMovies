//
//  APIHandlerService.swift
//  Favourite MoviesTests
//
//  Created by Ashrith Jain on 10/07/22.
//

import XCTest
@testable import Favourite_Movies

class APIHandlerService:APIHandlerDelegate{
    var value :Result<Data, ErrorModel> = .failure(.Nodata)
    
    func fetchData(url: URLRequest, completion: @escaping (Result<Data, ErrorModel>) -> Void) {
        completion(value)
    }
}
