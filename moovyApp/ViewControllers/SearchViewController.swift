//
//  SearchViewController.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var searchedResultsCollectionView: UICollectionView!
    var searchResults: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedResultsCollectionView.dataSource = self
        moviesSearchBar.delegate = self
        searchedResultsCollectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
}

extension SearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = self.moviesSearchBar.text, !searchText.isEmpty {
            APIClient.shared.searchMovie(movieName: searchText) { (result: Result<[Movie], Error>) in
                switch result {
                case .success(let movies):
                    print(movies)
                    self.searchResults = movies
                    self.searchedResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.configure(posterPath: (searchResults[indexPath.row].posterPath) ?? "")
        return cell
    }
}
