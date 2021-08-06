//
//  APIClientMoviesExtension.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 7/30/21.
//

import Alamofire
import ObjectMapper

extension APIClient {
    
    func fetchMoviesWithGenre(genreIdsArray: [String], page: Int, onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestItems(request: MovieListRoute.fetchMoviesWithGenre(genreIdsArray: genreIdsArray, page: page), responseKey: "results", onCompletion: onCompletion)
    }
    
    func fetchGenres(onCompletion: @escaping (Result<[Genre], Error>) -> Void) {
        requestItems(request: GenreRoute.fetchGenres, responseKey: "genres", onCompletion: onCompletion)
    }
    
    func searchMovie(movieName: String, onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestItems(request: MovieListRoute.searchMovie(movieName: movieName), responseKey: "results", onCompletion: onCompletion)
    }
    
    func fetchFavoriteMovies(onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestItems(request: MovieListRoute.fetchFavoriteMovies, responseKey: "results", onCompletion: onCompletion)
    }
    
    func addFavoriteMovie(movieId: Int, onCompletion: @escaping (Result<MarkFavoriteMovieResponse, Error>) -> Void) {
        requestItem(request: MovieListRoute.addFavoriteMovie(movieId: movieId), onCompletion: onCompletion)
    }
    
    func fetchSimilarMovies(movieId: Int, onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestItems(request: MovieListRoute.fetchSimilarMovies(movieId: movieId), responseKey: "results", onCompletion: onCompletion)
    }
}
