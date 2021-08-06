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
    case fetchFavoriteMovies
    case addFavoriteMovie(movieId: Int)
    case fetchSimilarMovies(movieId: Int)
    
    var sessionPolicy: APIRouteSessionPolicy {
        switch self {
        case .fetchMoviesWithGenre, .searchMovie, .fetchSimilarMovies:
            return .publicDomain
        case .fetchFavoriteMovies, .addFavoriteMovie:
            return .privateDomain
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchMoviesWithGenre, .searchMovie, .fetchFavoriteMovies, .fetchSimilarMovies:
            return .get
        case .addFavoriteMovie:
            return .post
        }
    }
    
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
            params = ["query": movieName]
            
        case .fetchFavoriteMovies:
            path = "/account/{account_id}/favorite/movies"
            params = [:]
        
        case .addFavoriteMovie(let movieId):
            path = "/account/{account_id}/favorite"
            params = [
                "media_type": "movie",
                "media_id": movieId,
                "favorite": true
            ]
        
        case .fetchSimilarMovies(let movieId):
            path = "/movie/\(String(movieId))/similar"
            params = [:]
        }
        
        return try self.encoded(path: path, params: params)
    }
}
