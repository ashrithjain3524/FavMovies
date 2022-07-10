//
//  MovieListingViewController.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import UIKit

protocol CellUpdate {
    func onLayoutChangeNeeded()
}

class MovieListingViewController: UIViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieListTable: UITableView!
    var viewModel:MovieListingViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseView()
        // Do any additional setup after loading the view.
    }
    
    func initialiseView(){
        bindViews()
        setUpView()
        viewModel.fetchMovieList(page: 1)
    }
    
}

extension MovieListingViewController{
    func bindViews() {
        
        viewModel.showActivity.bind {[weak self] (value) in
            self?.showActivityIndicator(show: value)
        }
        
        viewModel.reloadTable.bind { [weak self] (value) in
            if(value){
                DispatchQueue.main.async {
                    self?.movieListTable.reloadData()
                }
            }
            
        }
        
        viewModel.errorPop.bind(listener: { [weak self](value) in
            switch value{
            case .NoInterNet:
                self?.showAlert()
                break
            default:
                break
            }
        })
        
    }
    
    func showAlert(){
        let dialogMessage = UIAlertController(title: "No Internet", message: "It seems you are not connected to any internet", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
            self.viewModel.fetchMovieList(page: 1)
        })
        let cancel = UIAlertAction(title: "Offline Mode", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func setUpView(){
        self.setNavigationTitle(title: "Movies")
        self.movieSearchBar.delegate = self
        self.movieListTable.delegate = self
        self.movieListTable.dataSource = self
        movieListTable.register(UINib(nibName: "MovieDescrptionCell", bundle: nil), forCellReuseIdentifier: "MovieDescrptionCell")
        movieListTable.rowHeight = UITableView.automaticDimension
        movieListTable.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension MovieListingViewController:UITableViewDataSource,CellUpdate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescrptionCell") as! MovieDescrptionCell
        let movie = self.viewModel.movieList[indexPath.row]
        cell.setup(delegate: self, movie:movie)
        
        return cell
    }
    
    func onLayoutChangeNeeded() {
        movieListTable.beginUpdates()
        movieListTable.endUpdates()
    }
}

extension MovieListingViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.viewModel.movieList[indexPath.row]
        let detailController = MovieDetailViewController.getInstance(movie: movie)
        self.navigationController?.pushViewController(detailController, animated: true)
    }
}

extension MovieListingViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.movieList = self.filterMovieList(text: searchText)
        viewModel.reloadTable.value = true
    }
    
    func filterMovieList(text:String) -> [Movie] {

        let list = viewModel.responseObject?.results ?? []
        guard text != "" else {
            return list
        }
        let filteredList = list.filter { (movie) -> Bool in
            return movie.title?.contains(text) ?? false
        }
        return filteredList
    }
}

extension MovieListingViewController{
    static func getInstance()->UIViewController{
        let controller = UIStoryboard.getMainStoryBoard().instantiateViewController(forClass: MovieListingViewController.self)
        controller.viewModel = MovieListingViewModel()
        return controller
    }
}
