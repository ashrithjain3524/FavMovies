//
//  BaseViewModel.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation

class BaseViewModel: NSObject {
    var showActivity = Bindable.init(false)
    var reloadTable = Bindable.init(false)
    var showErrorPopUp = Bindable.init("")
    
}
