//
//  MovieDetailRequestModelTest.swift
//  Favourite MoviesTests
//
//  Created by Ashrith Jain on 10/07/22.
//

import XCTest
@testable import Favourite_Movies

class MovieDetailRequestModelTest: XCTestCase {
    var requestHandler = MovieDetailRequestModel(movieId: 123)
    
    func test_Request_Url_success(){
        let path = "/3/movie" + "/\(123)?api_key=\(Constant.APIKey)"
        XCTAssert(requestHandler.path  == path)
    }
}
