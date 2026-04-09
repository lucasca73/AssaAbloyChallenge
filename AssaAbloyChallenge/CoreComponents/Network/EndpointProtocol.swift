//
//  Endpoint.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
}

protocol Endpoint {
    var authNeeded: Bool { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    
    var baseURL: URL { AppConfig.current.baseURL }
    
    func urlRequest(token: String? = nil) throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let token = token {
            request.allHTTPHeaderFields = (headers ?? [:])
                .merging(["Authorization": "Bearer \(token)"],
                         uniquingKeysWith: { _, new in new })
        } else {
            request.allHTTPHeaderFields = headers
        }
        

        if let body {
            request.httpBody = try JSONEncoder().encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}
