//
//  ResponseHandler.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation

struct ResponseHandler {
    
    static func handle<T>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        // Network error
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        
        // HTTP response check
        guard let http = response as? HTTPURLResponse else {
            completion(.failure(.invalidResponse))
            return
        }
        
        switch http.statusCode {
        case 200...299: break
        case 400: completion(.failure(.badRequest)); return
        case 401: completion(.failure(.unauthorized)); return
        case 403: completion(.failure(.forbidden)); return
        case 404: completion(.failure(.notFound)); return
        case 500: completion(.failure(.internalServerError)); return
        case 502...504: completion(.failure(.serverUnavailable)); return
        default:
            completion(.failure(.serverError(statusCode: http.statusCode, message: nil)))
            return
        }
        
        // Check data exists
        guard let data = data else {
            completion(.failure(.noData))
            return
        }
        
        // Decide whether to decode JSON or return raw Data
        if T.self == Data.self {
            completion(.success(data as! T)) // raw Data
        } else if let type = T.self as? Decodable.Type {
            // Decode JSON only if T conforms to Decodable
            do {
                let decoded = try JSONDecoder().decode(type, from: data)
                completion(.success(decoded as! T))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        } else {
            completion(.failure(.decodingError(APIError.decodingError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Type T is not Decodable"])))))
        }
    }
}
