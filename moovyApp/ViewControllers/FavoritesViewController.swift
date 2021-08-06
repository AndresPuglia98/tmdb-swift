//
//  FavoritesViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoriteMoviesTableView: UITableView!
    
    static let notificationName = Notification.Name("didAddFavoriteMovie")
    
    var selectedMovie: Movie!
    var favoriteMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification(notification:)), name: FavoritesViewController.notificationName, object: nil)
        
        favoriteMoviesTableView.delegate = self
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.register(UINib(nibName: PresentMovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PresentMovieTableViewCell.identifier)
        APIClient.shared.fetchFavoriteMovies(onCompletion: self.handleFavoriteMoviesResponse)
    }
    
    @objc func onNotification(notification: Notification)
    {
        favoriteMovies.append(notification.userInfo?["newFavoriteMovie"] as! Movie)
        self.favoriteMoviesTableView.reloadData()
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

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = favoriteMovies[indexPath.row]
        self.performSegue(withIdentifier: "ShowMovieDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetailSegue" {
            let movieDetailsViewController = segue.destination as! MovieDetailsViewController
            movieDetailsViewController.selectedMovie = self.selectedMovie
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
