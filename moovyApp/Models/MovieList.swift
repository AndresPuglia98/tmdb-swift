//
//  MovieList.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/27/21.
//

import Foundation

class MovieList {
    
    var category: String
    var movies: Array<Movie>
    
    init(category: String) {
        self.category = category
        self.movies = []
    }
}
