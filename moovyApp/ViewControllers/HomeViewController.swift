//
//  HomeViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var genresToShow: [Genre] = []
    var moviesWithGenreId: [UICollectionView: Int] = [:]
    var movieListsToShow: [Int: [Movie]] = [:]
    var selectedGenre: Genre!
    var selectedMovie: Movie!
    let moviesPerRow: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonAction))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(.black)
        
        moviesTableView.dataSource = self
        moviesTableView.register(UINib(nibName: MoviesTableViewCell.identifier, bundle: nil),forCellReuseIdentifier: MoviesTableViewCell.identifier)
        
        fetchContent()
    }
    
    func fetchContent() -> Void {
        APIClient.shared.fetchGenres(onCompletion: handleFetchGenresResponse)
    }
    
    func handleFetchGenresResponse(result: Result<[Genre], Error>) -> Void {
        switch result {
        case .success(let genres):
            for genre in genres {
                if Constants.APIConstants.kGenresAtHomePage.contains(genre.name) {
                    self.genresToShow.append(genre)
                    APIClient.shared.fetchMoviesWithGenre(genreIdsArray: [String(genre.id)], page: 1) { (result: Result<[Movie], Error>) in
                        switch result {
                        case .success(let movies):
                            self.movieListsToShow[genre.id] = movies
                            self.moviesTableView.reloadData()
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
    }
    
    @objc func logoutButtonAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "sessionId")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genresToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as! MoviesTableViewCell
        moviesWithGenreId[cell.moviesCollectionView] = indexPath.row
        cell.moviesCollectionView.delegate = self
        cell.moviesCollectionView.dataSource = self
        cell.moviesCollectionView.reloadData()
        cell.configure(genre: genresToShow[indexPath.row].name)
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexRow = moviesWithGenreId[collectionView]!
        let movies = movieListsToShow[genresToShow[indexRow].id]
        if indexPath.row == moviesPerRow - 1 {
            self.selectedGenre = genresToShow[indexRow]
            self.performSegue(withIdentifier: "ShowMoreSegue", sender: self)
        }
        else {
            self.selectedMovie = movies?[indexPath.row]
            self.performSegue(withIdentifier: "ShowMovieDetailSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMoreSegue" {
            let moviesByGenreViewController = segue.destination as! MoviesByGenreViewController
            moviesByGenreViewController.selectedGenre = self.selectedGenre
        }
        if segue.identifier == "ShowMovieDetailSegue" {
            let movieDetailsViewController = segue.destination as! MovieDetailsViewController
            movieDetailsViewController.selectedMovie = self.selectedMovie
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesPerRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == self.moviesPerRow-1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowMoreCollectionViewCell.identifier, for: indexPath) as! ShowMoreCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
            let indexRow = moviesWithGenreId[collectionView]!
            let movies = movieListsToShow[genresToShow[indexRow].id]
            cell.configure(posterPath: (movies?[indexPath.row].posterPath) ?? "")
            return cell
        }
        
        
    }
}
