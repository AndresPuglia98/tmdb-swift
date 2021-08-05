//
//  SessionTokenResponse.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/4/21.
//

import ObjectMapper

struct SessionTokenResponse: ImmutableMappable {
    
    let success: Bool
    let sessionId: String?

    init(map: Map) throws {
        self.success = try map.value(Keys.success.rawValue)
        self.sessionId = try? map.value(Keys.session_id.rawValue)
    }
    
    enum Keys: String {
        case success
        case session_id
    }
}
