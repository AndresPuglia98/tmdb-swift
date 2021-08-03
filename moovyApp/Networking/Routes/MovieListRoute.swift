//
//  MovieListRoute.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import Foundation
import Alamofire

enum MovieListRoute: APIRoute {
    case fetchMoviesWithGenre(genreIdsArray: [String], page: Int)
    case searchMovie(movieName: String)

    var method: HTTPMethod { .get }
    
    var sessionPolicy: APIRouteSessionPolicy { .publicDomain }
    
    func asURLRequest() throws -> URLRequest {
        let path: String
        let params: [String: Any]
        
        switch self {
        case .fetchMoviesWithGenre(let genreIdsArray, let page):
            path = "/discover/movie"
            params = [
                "with_genres": genreIdsArray.joined(separator: ","),
                "page": page
            ]
        case .searchMovie(let movieName):
            path = "/search/movie"
            params = ["query" : movieName]
        }
        return try self.encoded(path: path, params: params)
    }
}
