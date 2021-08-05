//
//  PresentMovieTableViewCell.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/5/21.
//

import UIKit
import Cosmos
import Kingfisher

class PresentMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var ratingCosmosView: CosmosView!
    
    
    static let identifier = "PresentMovieTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(movieTitle: String, rating: Double, posterPath: String) {
        movieTitleLabel.text = movieTitle
        ratingCosmosView.rating = rating/2
        if(!posterPath.isEmpty) {
            let url = URL(string: "\(Constants.APIConstants.kBaseImageURL)\(posterPath)")
            moviePosterImageView.kf.setImage(with: url)
        } else {
            moviePosterImageView.image = UIImage(named: "defaultPoster")
        }
    }
}
