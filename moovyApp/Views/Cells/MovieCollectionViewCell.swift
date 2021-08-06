//
//  MovieCollectionViewCell.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/2/21.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    static let identifier = "MovieCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(posterPath: String) {
        if(!posterPath.isEmpty) {
            let url = URL(string: "\(Constants.APIConstants.kBaseImageURL)\(posterPath)")
            moviePosterImageView.kf.setImage(with: url)
        } else {
            moviePosterImageView.image = UIImage(named: "defaultPoster")
        }
    }

}
