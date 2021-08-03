//
//  HomeViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var genres: [Genre] = []
    
    var moviesGenreAtIndex: [UICollectionView: Int] = [:]
    var movieList: [Int: [Movie]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: MoviesTableViewCell.identifier, bundle: nil),forCellReuseIdentifier: MoviesTableViewCell.identifier)
        moviesTableView.reloadData()
        
//        moviesTableView.delegate = self
        
        APIClient.shared.fetchGenres { (result: Result<[Genre], Error>) in
            switch result {
            case .success(let genres):
                self.genres = genres
                for genre in genres {
                    if Constants.APIConstants.kGenresAtHomePage.contains(genre.name) {
                        APIClient.shared.fetchMoviesWithGenre(genreIdsArray: [String(genre.id)], page: 1) { (result: Result<[Movie], Error>) in
                            switch result {
                            case .success(let movies):
                                print(movies)
                                self.movieList[genre.id] = movies
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                    self.moviesTableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
      
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as! MoviesTableViewCell
        moviesGenreAtIndex[cell.moviesCollectionView] = indexPath.row
        cell.moviesCollectionView.delegate = self
        cell.moviesCollectionView.dataSource = self
        cell.moviesCollectionView.reloadData()
        cell.configure(genre: genres[indexPath.row].name)
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexRow = moviesGenreAtIndex[collectionView] ?? 0
        let movies = movieList[genres[indexRow].id]
        let selectedMovie = movies?[indexPath.row] // TODO: segue
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let indexRow = moviesGenreAtIndex[collectionView] ?? 0
        return movieList[genres[indexRow].id]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        let indexRow = moviesGenreAtIndex[collectionView] ?? 0
        let movies = movieList[genres[indexRow].id]
        cell.configure(posterPath: (movies?[indexPath.row].posterPath) ?? "")
        return cell
    }
}
