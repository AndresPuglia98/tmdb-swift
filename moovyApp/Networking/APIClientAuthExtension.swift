//
//  APIClientAuthExtension.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/4/21.
//

import Alamofire
import ObjectMapper

extension APIClient {
    
    func generateToken(onCompletion: @escaping (Result<RequestTokenResponse, Error>) -> Void)
    {
        requestItem(request: AuthRoute.generateToken, onCompletion: onCompletion)
    }
    
    func validateUser(username: String, password: String, requestToken: String, onCompletion: @escaping (Result<RequestTokenResponse, Error>) -> Void)
    {
        requestItem(request: AuthRoute.validateUser(username: username, password: password, requestToken: requestToken), onCompletion: onCompletion)
    }
    
    func createSession(requestToken: String, onCompletion: @escaping (Result<SessionTokenResponse, Error>) -> Void)
    {
        requestItem(request: AuthRoute.createSession(requestToken: requestToken), onCompletion: onCompletion)
    }
}
