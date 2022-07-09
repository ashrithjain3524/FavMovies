//
//  API.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

extension Constant {
    static let BaseUrl: String = "https://api.nytimes.com"
    static let APIKey: String = "2JxNjh0SA9aA3tEIxHjRQ3yTHMIZ6X1r"
    
    enum API{
        case popularNews(days:PeriodsAllowed)
        
        func getRawValue()->String{
            switch self {
            case .popularNews(let noDays):
                var rawValue =  BaseAPI.popularNews.rawValue
                rawValue = rawValue + "/\(noDays.rawValue).json?api-key=\(Constant.APIKey)"
                return rawValue
            }
        }
    }
    
    enum BaseAPI:String{
        case popularNews = "/svc/mostpopular/v2/viewed"
    }
    
    enum PeriodsAllowed:Int {
        case one = 1
        case seven = 7
        case thirty = 30
    }
    
}
