//
//  RequestTokenResponse.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/4/21.
//

import Foundation
import ObjectMapper

struct RequestTokenResponse: ImmutableMappable {
    
    let success: Bool
    let requestToken: String?

    init(map: Map) throws {
        self.success = try map.value(Keys.success.rawValue)
        self.requestToken = try? map.value(Keys.request_token.rawValue)
    }
    
    enum Keys: String {
        case success
        case request_token
    }
}
