//
//  Genre.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/28/21.
//

import Foundation
import ObjectMapper

struct Genre: ImmutableMappable {
    
    let id: Int
    let name: String

    init(map: Map) throws {
        self.id = try map.value(Keys.id.rawValue)
        self.name = try map.value(Keys.name.rawValue)
    }
    
    enum Keys: String {
        case id
        case name
    }
}
