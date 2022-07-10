//
//  ResponseHandlerService.swift
//  Favourite MoviesTests
//
//  Created by Ashrith Jain on 10/07/22.
//

import XCTest
@testable import Favourite_Movies

class ResponseHandlerService: ResponseHandlerDelegate {
    func handleResponse<T>(type: T.Type, data: Data, completion: @escaping (Result<T, ErrorModel>) -> Void) where T : Decodable, T : Encodable {
        completion(.failure(.Nodata))
    }
}
