//
//  NetworkManager.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation

// MARK: - Network Service Protocol
protocol NetworkService {
    func request<T: Decodable>(_ request: APIRequest,completion: @escaping (Result<T, APIError>) -> Void)
    func loadImage(from url: URL,completion: @escaping (Result<Data, APIError>) -> Void)
    func clearImageCache()
}

final class NetworkManager: NetworkService {
    
    static let shared = NetworkManager()
    private let imageCache = NSCache<NSString, NSData>()
    private init() {}
    
    // MARK: - Generic Request
    func request<T: Decodable>(_ request: APIRequest,completion: @escaping (Result<T, APIError>) -> Void) {
        do {
            let urlRequest = try buildURLRequest(from: request)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                ResponseHandler.handle(data: data, response: response, error: error, completion: completion)
            }.resume()
        } catch {
            completion(.failure(.networkError(error)))
        }
    }
    
    // MARK: - Image Loading with Cache
    func loadImage(from url: URL,completion: @escaping (Result<Data, APIError>) -> Void) {
        if let cached = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cached as Data))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            ResponseHandler.handle(data: data, response: response, error: error) { (result: Result<Data, APIError>) in
                if case .success(let data) = result {
                    self.imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                }
                completion(result)
            }
        }.resume()
    }
    
    func clearImageCache() {
        imageCache.removeAllObjects()
    }
    
    // MARK: - Private Helpers
    private func buildURLRequest(from request: APIRequest) throws -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        
        request.headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let params = request.parameters {
            switch request.parameterEncoding {
            case .url:
                var components = URLComponents(string: request.url.absoluteString)
                components?.queryItems = params.map { key, value in
                    URLQueryItem(name: key, value: String(describing: value))
                }
                if let newURL = components?.url {
                    urlRequest.url = newURL
                }

            case .json:
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        return urlRequest
    }
}
