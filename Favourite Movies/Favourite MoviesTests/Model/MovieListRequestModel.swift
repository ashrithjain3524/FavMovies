//
//  MovieListRequestModel.swift
//  Favourite MoviesTests
//
//  Created by Ashrith Jain on 10/07/22.
//

import XCTest
@testable import Favourite_Movies

class MovieListRequestModelTest: XCTestCase {
    var requestHandler = MoviesListRequestModel(page: 1)
    
    func test_Request_Url_success(){
        let path = "/4/list" + "/\(1)?api_key=\(Constant.APIKey)"
        XCTAssert(requestHandler.path  == path)
    }
}
