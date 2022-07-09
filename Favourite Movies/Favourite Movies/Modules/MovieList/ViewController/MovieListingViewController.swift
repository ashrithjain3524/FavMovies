//
//  MovieListingViewController.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import UIKit

class MovieListingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension MovieListingViewController{
    static func getInstance()->UIViewController{
        let controller = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: MovieListingViewController.self)
        //controller.viewModel = NewsListingViewModel()
        return controller
    }
}
