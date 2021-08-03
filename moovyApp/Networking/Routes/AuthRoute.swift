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

    var method: HTTPMethod { .get }
    
    var sessionPolicy: APIRouteSessionPolicy { .publicDomain }
    
    func asURLRequest() throws -> URLRequest {
        let path: String
        let params: [String: Any]
        
        switch self {
        case .generateToken:
            path = "/authentication/token/new"
            params = [:]
        case .validateUser:
            path = "/authentication/token/validate_with_login" // Configurar para que sea POST
            params = [:]
        case .createSession:
            path = "/authentication/session/new" // Configurar para que sea POST
            params = [:]
        }
        
        return try self.encoded(path: path, params: params)
    }
}
