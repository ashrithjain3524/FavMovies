//
//  APIHandler.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

protocol APIHandlerDelegate {
    func fetchData(url:URLRequest,completion: @escaping(Result<Data,ErrorModel>)->Void)
}

class APIHandler:APIHandlerDelegate {
    func fetchData(url:URLRequest,completion: @escaping(Result<Data,ErrorModel>)->Void){
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            guard let data = data,error == nil else{
                return completion(.failure(.Nodata))
            }
            completion(.success(data))
        }.resume()
    }
}
