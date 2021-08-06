//
//  MarkFavoriteMovieResponse.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/5/21.
//

import ObjectMapper

struct MarkFavoriteMovieResponse: ImmutableMappable {
    
    let statusCode: Int
    let statusMessage: String

    init(map: Map) throws {
        self.statusCode = try map.value(Keys.status_code.rawValue)
        self.statusMessage = try map.value(Keys.status_message.rawValue)
    }
    
    enum Keys: String {
        case status_code
        case status_message
    }
}
