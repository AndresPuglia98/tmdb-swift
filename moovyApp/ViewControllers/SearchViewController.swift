//
//  SearchViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var searchedResultsTableView: UITableView!
    
    var selectedMovie: Movie!
    var searchResults: [Movie] = []
    var debounceTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesSearchBar.delegate = self
        searchedResultsTableView.delegate = self
        searchedResultsTableView.dataSource = self
        searchedResultsTableView.register(UINib(nibName: PresentMovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PresentMovieTableViewCell.identifier)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = searchResults[indexPath.row]
        self.performSegue(withIdentifier: "ShowMovieDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetailSegue" {
            let movieDetailsViewController = segue.destination as! MovieDetailsViewController
            movieDetailsViewController.selectedMovie = self.selectedMovie
        }
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = self.moviesSearchBar.text, !searchText.isEmpty {
            debounceTimer?.invalidate()
            debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                APIClient.shared.searchMovie(movieName: searchText, onCompletion: self.handleSearchResponse)
            }
        }
        
        if(searchText.isEmpty) {
            self.searchResults = []
            self.searchedResultsTableView.reloadData()
        }
    }
    
    func handleSearchResponse(result: Result<[Movie], Error>) -> Void {
        switch result {
        case .success(let movies):
            self.searchResults = movies
            self.searchedResultsTableView.reloadData()

        case .failure(let error):
            print(error)
        }
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PresentMovieTableViewCell.identifier, for: indexPath) as! PresentMovieTableViewCell
        let movie = searchResults[indexPath.row]
        cell.configure(movieTitle: movie.title, rating: movie.rating, posterPath: (movie.posterPath) ?? "")
        return cell
    }
}
