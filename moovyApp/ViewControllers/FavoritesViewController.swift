//
//  FavoritesViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    
    var favoriteMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.register(UINib(nibName: PresentMovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PresentMovieTableViewCell.identifier)
        APIClient.shared.fetchFavoriteMovies(onCompletion: self.handleFavoriteMoviesResponse)
    }
    
    func handleFavoriteMoviesResponse(result: Result<[Movie], Error>) -> Void {
        switch result {
        case .success(let movies):
            self.favoriteMovies = movies
            self.favoriteMoviesTableView.reloadData()

        case .failure(let error):
            print(error)
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PresentMovieTableViewCell.identifier, for: indexPath) as! PresentMovieTableViewCell
        let movie = favoriteMovies[indexPath.row]
        cell.configure(movieTitle: movie.title, rating: movie.rating, posterPath: (movie.posterPath) ?? "")
        return cell
    }
}
