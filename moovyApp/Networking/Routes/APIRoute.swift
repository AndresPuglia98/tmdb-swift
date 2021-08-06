//
//  APIClient.swift
//  AFTest
//
//  Created by German Rodriguez on 7/20/21.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

enum APIRouteSessionPolicy {
    case privateDomain, publicDomain
}

protocol APIRoute: URLRequestConvertible {
    var method: HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var sessionPolicy: APIRouteSessionPolicy { get }
}

extension APIRoute {
    var baseURL: String { Constants.APIConstants.kBaseURL }
    
    var encoding: Alamofire.ParameterEncoding {
        switch self.method {
        case .get, .post, .delete, .patch: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }

    func encoded(path: String, params: JSONDictionary) throws -> URLRequest {
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        var params = params
        var url = URL(string: baseURL + encodedPath)!
            switch self.method {
            case .get, .post, .delete, .patch:
                if sessionPolicy == .privateDomain {
                    params["session_id"] = UserDefaults.standard.object(forKey: "sessionId")
                }
            default:
                var urlComponents = URLComponents(string: baseURL + encodedPath)!
                if sessionPolicy == .privateDomain {
                    urlComponents.queryItems?.append(URLQueryItem(name: "session_id", value: UserDefaults.standard.object(forKey: "sessionId") as? String))
                }
                url = try urlComponents.asURL()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        urlRequest.setValue("Bearer " + Constants.APIConstants.kApiBearerToken, forHTTPHeaderField: "Authorization")
        return try self.encoding.encode(urlRequest, with: params)
    }
}
