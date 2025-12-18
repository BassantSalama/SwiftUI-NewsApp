//
//  APIRequest.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

enum ParameterEncoding {
    case url
    case json
}

struct APIRequest {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]?
    let parameters: [String: Any]?
    let parameterEncoding: ParameterEncoding
    
    init(url: URL,
         method: HTTPMethod = .GET,
         headers: [String: String]? = nil,
         parameters: [String: Any]? = nil,
         parameterEncoding: ParameterEncoding = .url) {
        self.url = url
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.parameterEncoding = parameterEncoding
    }
}
