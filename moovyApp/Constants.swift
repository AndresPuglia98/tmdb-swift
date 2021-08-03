//
//  Constants.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import Foundation
import UIKit

struct Constants {
  
  struct APIConstants {
    static let kApiKey = "0c733948e8b63fcba8d849138b6a245c"
    static let kApiBearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYzczMzk0OGU4YjYzZmNiYThkODQ5MTM4YjZhMjQ1YyIsInN1YiI6IjYwYWJhZjBhZjg1OTU4MDA1N2I5MDg5MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.M1J9FJR0hFCpbEHxM3Tx402GHZtGgmX11WGR5knuH-0"
    
    static let kBaseURL = "https://api.themoviedb.org/3"
    static let kBaseImageURL = "https://image.tmdb.org/t/p/w500"
    static let kGenresAtHomePage = [
        "Action",
        "Adventure",
        "Animation",
        "Family",
        "History",
        "Music",
        "Romance",
        "Comedy"
    ]
  }
}
