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
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var selectedContent: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieTitleLabel.text = selectedContent.title
        if selectedContent.posterPath != nil {
            let url = URL(string: "\(Constants.APIConstants.kBaseImageURL)\(selectedContent.posterPath ?? "")")
            moviePosterImageView.kf.setImage(with: url)
        } else {
            moviePosterImageView.image = UIImage(named: "defaultPoster")
        }
        
        movieDescriptionLabel.text = selectedContent.title
        if (movieTitleLabel.text?.isEmpty)! {
            movieTitleLabel.text = Constants.DefaultTexts.kDefaultTitle
        }
        
        movieDescriptionLabel.text = selectedContent.overview
        if (movieDescriptionLabel.text?.isEmpty)! {
            movieDescriptionLabel.text = Constants.DefaultTexts.kDefaultOverview
        }
        movieDescriptionLabel.sizeToFit()
    }
}
