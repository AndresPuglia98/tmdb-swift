//
//  GenreRoute.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/1/21.
//

import Foundation
import Alamofire

enum GenreRoute: APIRoute {
    case fetchGenres

    var method: HTTPMethod { .get }
    
    var sessionPolicy: APIRouteSessionPolicy { .publicDomain }
    
    func asURLRequest() throws -> URLRequest {
        let path: String
        let params: [String: Any]
        
        switch self {
        case .fetchGenres:
            path = "/genre/movie/list"
            params = [:]
        }
        return try self.encoded(path: path, params: params)
    }
}
