//
//  MovieItem.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/27/21.
//

import Foundation
import ObjectMapper

struct Movie: ImmutableMappable {
    
    let id: Int
    let title: String
    var posterPath: String? = nil
    let genreIds: Array<Int>
    let overview: String
    let rating: Double
    var tagline: String? = nil
    var status: String? = nil
    var releaseDate: String? = nil
    
    init(map: Map) throws {
        self.id = try map.value(Keys.id.rawValue)
        self.title = try map.value(Keys.title.rawValue)
        self.posterPath = try? map.value(Keys.poster_path.rawValue)
        self.genreIds = try map.value(Keys.genre_ids.rawValue)
        self.overview = try map.value(Keys.overview.rawValue)
        self.rating = try map.value(Keys.vote_average.rawValue)
        self.tagline = try? map.value(Keys.tagline.rawValue)
        self.status = try? map.value(Keys.status.rawValue)
        self.releaseDate = try? map.value(Keys.release_date.rawValue)
    }
    
    enum Keys: String {
        case id
        case title
        case poster_path
        case genre_ids
        case overview
        case vote_average
        case tagline
        case status
        case release_date
    }
}
