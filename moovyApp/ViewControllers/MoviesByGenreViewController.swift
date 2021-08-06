//
//  MoviesByGenreViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/3/21.
//


import UIKit

class MoviesByGenreViewController: UIViewController {
    
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var moviesByGenreTableView: UITableView!
    
    var selectedGenre: Genre!
    var selectedMovie: Movie!
    var moviesByGenre: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        genreNameLabel.text = selectedGenre.name
        
        moviesByGenreTableView.delegate = self
        moviesByGenreTableView.dataSource = self
        moviesByGenreTableView.register(UINib(nibName: PresentMovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PresentMovieTableViewCell.identifier)
        
        APIClient.shared.fetchMoviesWithGenre(genreIdsArray: [String(selectedGenre.id)], page: 1, onCompletion: handleMoviesByGenreResponse)
    }
    
    func handleMoviesByGenreResponse(result: Result<[Movie], Error>) -> Void {
        switch result {
        case .success(let movies):
            self.moviesByGenre = movies
            self.moviesByGenreTableView.reloadData()

        case .failure(let error):
            print(error)
        }
    }
}

extension MoviesByGenreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = moviesByGenre[indexPath.row]
        self.performSegue(withIdentifier: "ShowMovieDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetailSegue" {
            let movieDetailsViewController = segue.destination as! MovieDetailsViewController
            movieDetailsViewController.selectedMovie = self.selectedMovie
        }
    }
}

extension MoviesByGenreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesByGenre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PresentMovieTableViewCell.identifier, for: indexPath) as! PresentMovieTableViewCell
        let movie = moviesByGenre[indexPath.row]
        cell.configure(movieTitle: movie.title, rating: movie.rating, posterPath: (movie.posterPath) ?? "")
        return cell
    }
}
