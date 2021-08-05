//
//  MoviesTableViewCell.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/2/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesGenreLabel: UILabel!
    
    static let identifier = "MoviesTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviesCollectionView.register(UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        moviesCollectionView.register(UINib(nibName: ShowMoreCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: ShowMoreCollectionViewCell.identifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(genre: String) {
        moviesGenreLabel.text = genre
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
