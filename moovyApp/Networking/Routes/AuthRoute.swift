//
//  AuthRoute.swift
//  moovyApp
//
//  Created by José Andrés Puglia on 8/1/21.
//

import Foundation
import Alamofire

enum AuthRoute: APIRoute {
    case generateToken
    case validateUser(username: String, password: String, requestToken: String)
    case createSession(requestToken: String)

    var method: HTTPMethod {
        switch self {
        case .generateToken:
            return .get
        case .validateUser:
            return .post
        case .createSession:
            return .post
        }
    }
    
    var sessionPolicy: APIRouteSessionPolicy { .publicDomain }
    
    func asURLRequest() throws -> URLRequest {
        let path: String
        let params: [String: Any]
        
        switch self {
        case .generateToken:
            path = "/authentication/token/new"
            params = [:]
            
        case .validateUser(let username, let password, let requestToken):
            path = "/authentication/token/validate_with_login"
            params = [
                "username": username,
                "password": password,
                "request_token": requestToken
            ]
            
        case .createSession(let requestToken):
            path = "/authentication/session/new"
            params = ["request_token": requestToken]
        }
        
        return try self.encoded(path: path, params: params)
    }
}
