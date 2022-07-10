//
//  UIStoryBoard+Extension.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation
import UIKit


extension UIStoryboard{
    enum StoryboardIdentifiers : String {
        case main = "Main"
    }
    class func getMainStoryBoard()->UIStoryboard{
        return UIStoryboard(name: StoryboardIdentifiers.main.rawValue, bundle: nil)
    }
    
    func instantiateViewController<T>(withId: String? = nil, forClass: T.Type) -> T {
        let identifier = withId ?? String(describing: T.self)
        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}
