//
//  APIError.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation


public enum APIError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case noData
    case decodingError(Error)
    case badRequest          // 400
    case unauthorized        // 401
    case forbidden           // 403
    case notFound            // 404
    case internalServerError // 500
    case serverUnavailable   // 502-504
    case serverError(statusCode: Int, message: String?)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL."
        case .networkError(let e): return "Network error: \(e.localizedDescription)"
        case .invalidResponse: return "Invalid response."
        case .noData: return "No data returned."
        case .decodingError(let e): return "Decoding failed: \(e.localizedDescription)"
        case .badRequest: return "Bad request (400)."
        case .unauthorized: return "Unauthorized (401)."
        case .forbidden: return "Forbidden (403)."
        case .notFound: return "Not found (404)."
        case .internalServerError: return "Internal server error (500)."
        case .serverUnavailable: return "Server unavailable (502-504)."
        case .serverError(let code, let message):
            return "Server error (\(code)): \(message ?? "No message")"
        }
    }
}
