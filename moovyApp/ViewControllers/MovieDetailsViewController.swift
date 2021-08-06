//
//  MovieDetailsViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/3/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTaglineLabel: UILabel!
    @IBOutlet weak var movieStatusLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var similarMoviesTableView: UITableView!
    
    var selectedMovie: Movie!
    var similarMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        similarMoviesTableView.dataSource = self
        similarMoviesTableView.register(UINib(nibName: MoviesTableViewCell.identifier, bundle: nil),forCellReuseIdentifier: MoviesTableViewCell.identifier)
        
        APIClient.shared.fetchSimilarMovies(movieId: selectedMovie.id, onCompletion: self.handleSimilarMoviesResponse)
        
        if selectedMovie.posterPath != nil {
            let url = URL(string: "\(Constants.APIConstants.kBaseImageURL)\(selectedMovie.posterPath ?? "")")
            moviePosterImageView.kf.setImage(with: url)
        } else {
            moviePosterImageView.image = UIImage(named: "defaultPoster")
        }
        
        movieTitleLabel.text = selectedMovie.title
        if (movieTitleLabel.text?.isEmpty)! {
            movieTitleLabel.text = Constants.DefaultTexts.kDefaultTitle
        }
        
        movieTaglineLabel.text = selectedMovie.tagline
        if movieTaglineLabel.text == nil {
            movieTaglineLabel.text = Constants.DefaultTexts.kDefaultTagline
        }
        
        movieStatusLabel.text = selectedMovie.status
        if movieStatusLabel.text == nil {
            movieStatusLabel.text = Constants.DefaultTexts.kDefaultStatus
        }
        
        movieReleaseDateLabel.text = "Release date: \(selectedMovie.releaseDate ?? "")"
        if movieReleaseDateLabel.text == nil {
            movieReleaseDateLabel.text = Constants.DefaultTexts.kDefaultReleaseDate
        }
        
    }
    
    @IBAction func addFavoriteButtonAction(_ sender: Any) {
        APIClient.shared.addFavoriteMovie(movieId: selectedMovie.id) { (result: Result<MarkFavoriteMovieResponse, Error>) in
            switch result {
            case .success:
                NotificationCenter.default.post(name: FavoritesViewController.notificationName, object: nil, userInfo: ["newFavoriteMovie": self.selectedMovie!])
                print("Added \(self.selectedMovie.title) to favorites")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func handleSimilarMoviesResponse(result: Result<[Movie], Error>) -> Void {
        switch result {
        case .success(let movies):
            self.similarMovies = movies
            self.similarMoviesTableView.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
    
}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as! MoviesTableViewCell
        cell.moviesCollectionView.delegate = self
        cell.moviesCollectionView.dataSource = self
        cell.moviesCollectionView.reloadData()
        cell.configure(genre: "Similar movies")
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = similarMovies[indexPath.row]
        self.performSegue(withIdentifier: "ShowMovieDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetailSegue" {
            let movieDetailsViewController = segue.destination as! MovieDetailsViewController
            movieDetailsViewController.selectedMovie = self.selectedMovie
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.configure(posterPath: (similarMovies[indexPath.row].posterPath) ?? "")
        return cell
    }
}

