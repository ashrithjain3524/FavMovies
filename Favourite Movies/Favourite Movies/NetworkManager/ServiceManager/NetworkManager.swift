//
//  NetworkManager.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class NetworkManager {
    
    let aPIHandler:APIHandlerDelegate
    let responseHandler:ResponseHandlerDelegate
    
    init(aPIHandler:APIHandlerDelegate = APIHandler(),responseHandler:ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T:Codable>(type:T.Type,url:URLRequest,completion: @escaping(Result<T,ErrorModel>)->Void){
        aPIHandler.fetchData(url: url) { (result) in
            switch result{
            case .success(let data):
                self.responseHandler.handleResponse(type: type, data: data) { (decodableResult) in
                    switch decodableResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
