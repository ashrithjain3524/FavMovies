//
//  NetworkManagerTest.swift
//  Favourite MoviesTests
//
//  Created by Ashrith Jain on 10/07/22.
//

import XCTest
@testable import Favourite_Movies

class NetworkManagerTest: XCTestCase {
    var networkManager:NetworkManager!
    
    func test_NetworkManager_UrlReguest_failure() {
        let apiHandler = APIHandlerService()
        apiHandler.value = .failure(.BadUrl)
        
        let respinseHandler = ResponseHandlerService()
        
        networkManager = NetworkManager(aPIHandler: apiHandler, responseHandler: respinseHandler)
        let request = RequestModel()
        networkManager.fetchRequest(type: Int.self, url: request.urlRequest()) { (response) in
            XCTAssertTrue(response == .failure(.BadUrl))
        }

    }
    
    func test_NetworkManager_Decoding_failure() {
        let apiHandler = APIHandlerService()
        apiHandler.value = .failure(.DecodingError)
        
        let respinseHandler = ResponseHandlerService()
        
        networkManager = NetworkManager(aPIHandler: apiHandler, responseHandler: respinseHandler)
        let request = RequestModel()
        networkManager.fetchRequest(type: Int.self, url: request.urlRequest()) { (response) in
            XCTAssertTrue(response == .failure(.DecodingError))
        }

    }
    
    func test_NetworkManager_Nodata_failure() {
        let apiHandler = APIHandlerService()
        apiHandler.value = .failure(.Nodata)
        
        let respinseHandler = ResponseHandlerService()
        
        networkManager = NetworkManager(aPIHandler: apiHandler, responseHandler: respinseHandler)
        let request = RequestModel()
        networkManager.fetchRequest(type: Int.self, url: request.urlRequest()) { (response) in
            XCTAssertTrue(response == .failure(.Nodata))
        }

    }
    
    func test_NetworkManager_successResponse() {
        let apiHandler = APIHandlerService()
        let data = try! JSONEncoder().encode(1)
        apiHandler.value = .success(data)
        let respinseHandler = ResponseHandler()
        
        networkManager = NetworkManager(aPIHandler: apiHandler, responseHandler: respinseHandler)
        let request = RequestModel()
        networkManager.fetchRequest(type: Int.self, url: request.urlRequest()) { (response) in
            XCTAssertTrue(response == .success(1))
        }

    }

}
