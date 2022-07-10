//
//  MovieDescrptionCell.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation
import UIKit

class MovieDescrptionCell: UITableViewCell {
    @IBOutlet weak var dynamicImageView: DynamicImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    var delegate:CellUpdate?
    
    func setup(delegate:CellUpdate,movie:Movie){
        movieTitle.text = movie.title
        movieRating.text = "Ratings: \(movie.rating ?? 0.0)"
        let path = Constant.API.image(width: .w2, path: movie.poster ?? "").getRawValue()
        let url = Constant.ImageBaseUrl.appending(path)
        dynamicImageView.addImage(url, UIImage()){
            delegate.onLayoutChangeNeeded()
        }
        
    }
    
}
