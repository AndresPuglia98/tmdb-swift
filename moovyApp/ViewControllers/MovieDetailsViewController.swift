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
    
    var selectedContent: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedContent.posterPath != nil {
            let url = URL(string: "\(Constants.APIConstants.kBaseImageURL)\(selectedContent.posterPath ?? "")")
            moviePosterImageView.kf.setImage(with: url)
        } else {
            moviePosterImageView.image = UIImage(named: "defaultPoster")
        }
    
        movieTitleLabel.text = selectedContent.title
        if (movieTitleLabel.text?.isEmpty)! {
            movieTitleLabel.text = Constants.DefaultTexts.kDefaultTitle
        }
        
        movieTaglineLabel.text = selectedContent.tagline
        if (movieTaglineLabel.text == nil) {
            movieTaglineLabel.text = Constants.DefaultTexts.kDefaultTagline
        }
        
        movieStatusLabel.text = selectedContent.status
        if (movieStatusLabel.text == nil) {
            movieStatusLabel.text = Constants.DefaultTexts.kDefaultStatus
        }
        
        movieReleaseDateLabel.text = "Release date: \(selectedContent.releaseDate)"
        if (movieReleaseDateLabel.text?.isEmpty)!{
            movieReleaseDateLabel.text = Constants.DefaultTexts.kDefaultReleaseDate
        }
        
    }
    
    @IBAction func addFavoriteButtonAction(_ sender: Any) {
        APIClient.shared.addFavoriteMovie(movieId: selectedContent.id) { (result: Result<MarkFavoriteMovieResponse, Error>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
