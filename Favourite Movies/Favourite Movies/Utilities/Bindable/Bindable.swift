//
//  Bindable.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class Bindable<T>{
    
    typealias Listner = (T) -> Void
    var listener:Listner?
    
    var value:T{
        
        didSet{
            listener?(value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    func bind(listener:@escaping Listner){
        self.listener = listener
    }
}
