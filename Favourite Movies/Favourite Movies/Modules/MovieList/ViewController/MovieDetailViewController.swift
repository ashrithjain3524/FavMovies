//
//  MovieDetailViewController.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var viewModel:MovieDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseView()
        // Do any additional setup after loading the view.
    }
    
    func initialiseView(){
        bindViews()
        setUpView()
    }

}

extension MovieDetailViewController{
    func bindViews() {
        
        viewModel.showActivity.bind {[weak self] (value) in
            self?.showActivityIndicator(show: value)
        }
        viewModel.showErrorPopUp.bind(listener: { (value) in
            
        })
        
    }
    
    func setUpView(){
        self.setNavigationTitle(title: "Movies")
    }
}


extension MovieDetailViewController{
    static func getInstance(movie:Movie)->UIViewController{
        let controller = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: MovieDetailViewController.self)
        controller.viewModel = MovieDetailViewModel(movie: movie)
        return controller
    }
}

