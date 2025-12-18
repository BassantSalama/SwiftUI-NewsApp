//
//  APIRequestBuilder.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation

final class APIRequestBuilder {
    private var url: URL
    private var method: HTTPMethod = .GET
    private var headers: [String: String]?
    private var parameters: [String: Any]?
    private var parameterEncoding: ParameterEncoding = .url
    
    // Initialize with a base URL
    public init(url: URL) {
        self.url = url
    }
    
    // Set HTTP method
    @discardableResult
    func setMethod(_ method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    // Set headers
    @discardableResult
    func setHeaders(_ headers: [String: String]?) -> Self {
        self.headers = headers
        return self
    }
    
    // Set parameters and encoding
    @discardableResult
    func setParameters(_ parameters: [String: Any]?, encoding: ParameterEncoding) -> Self {
        self.parameters = parameters
        self.parameterEncoding = encoding
        return self
    }
    
    // Build APIRequest
    func build() -> APIRequest {
        return APIRequest(url: url,
                          method: method,
                          headers: headers,
                          parameters: parameters,
                          parameterEncoding: parameterEncoding)
    }
}
