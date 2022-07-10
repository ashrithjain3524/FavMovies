//
//  MovieDetailViewController.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var dynamicImage: DynamicImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var languages: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    var viewModel:MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseView()
        // Do any additional setup after loading the view.
    }
    
    func initialiseView(){
        bindViews()
        setUpView()
        setUpData()
        viewModel.fetchDetails(id: viewModel.movie.id ?? 0)
    }
    
}

extension MovieDetailViewController{
    func bindViews() {
        
        viewModel.showActivity.bind { [weak self] (value) in
            self?.showActivityIndicator(show: value)
        }
        
        viewModel.reloadTable.bind{ [weak self] (value) in
            if value{
                DispatchQueue.main.async {
                    self?.setUpData()
                }
                
            }
        }
        
        viewModel.showErrorPopUp.bind(listener: { (value) in
            
        })
        
    }
    
    func setUpView(){
        self.setNavigationTitle(title: "Movie Detail")
        self.setNavigationBackButtonTitle(title: "Movies")
    }
    
    func setUpData(){
        let movie = viewModel.movie
        movieTitle.text = movie.title
        rating.text = "Ratings: \(movie.rating ?? 0.0)"
        duration.text = "Duration: \(movie.getDuration())"
        releaseDate.text = "Release Date: \(movie.getReleaseDate())"
        languages.text = movie.getLanguages()
        aboutTextView.text = movie.overview ?? ""
        setUpImageView()
    }
    
    func setUpImageView(){
        let movie = viewModel.movie
        let path = Constant.API.image(width: .original, path: movie.poster ?? "").getRawValue()
        let url = Constant.ImageBaseUrl.appending(path)
        dynamicImage.addImage(url, UIImage()){[weak self] in
            if let image = UIImage(named: "a_image") {
                let ratio = image.size.width / image.size.height
                if (self?.dynamicImage.frame.width ?? 0.0) > (self?.dynamicImage.frame.height ?? 0.0) {
                    let newHeight = (self?.dynamicImage.frame.width ?? 0.0) / ratio
                    self?.imageHeight.constant = newHeight
                }
                else{
                    let newWidth = (self?.dynamicImage.frame.height ?? 0.0) * ratio
                    self?.imageWidth.constant = newWidth
                }
            }
            DispatchQueue.main.async {
                self?.dynamicImage.contentMode = .scaleAspectFill
            }
        }
    }
    
}


extension MovieDetailViewController{
    static func getInstance(movie:Movie)->UIViewController{
        let controller = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: MovieDetailViewController.self)
        controller.viewModel = MovieDetailViewModel(movie: movie)
        return controller
    }
}

