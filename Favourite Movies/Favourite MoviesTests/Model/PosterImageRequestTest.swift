//
//  PosterImageRequestTest.swift
//  Favourite MoviesTests
//
//  Created by Ashrith Jain on 10/07/22.
//

import XCTest
@testable import Favourite_Movies

class PosterImageRequestTest: XCTestCase {
    
    func test_Request_Url_success(){
        let path = Constant.API.image(width: .w2, path: "xyz").getRawValue()
        let url = Constant.ImageBaseUrl.appending(path)
        let imagePath = "https://image.tmdb.org" + "/t/p" + "/w154/xyz"
        XCTAssert(url == imagePath)
    }
}
