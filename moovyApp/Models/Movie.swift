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
    
    init(map: Map) throws {
        self.id = try map.value(Keys.id.rawValue)
        self.title = try map.value(Keys.title.rawValue)
        self.posterPath = try map.value(Keys.poster_path.rawValue)
        self.genreIds = try map.value(Keys.genre_ids.rawValue)
    }
    
    enum Keys: String {
        case id
        case title
        case poster_path
        case genre_ids
    }
}
