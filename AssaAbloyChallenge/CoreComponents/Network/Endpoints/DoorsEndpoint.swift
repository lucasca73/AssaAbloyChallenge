//
//  DoorsEndpoint.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

enum DoorsEndpoint: Endpoint {
    case list(page: Int, size: Int)
    case findByName(name: String)

    var path: String {
        switch self {
        case .list: return "/doors"
        case .findByName: return "/doors/search"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .list, .findByName: return .get
        }
    }

    var authNeeded: Bool { true }
    var body: (any Encodable)? { nil }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .list(page, size):
            return [URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "size", value: "\(size)")]
        case let .findByName(name):
            return [URLQueryItem(name: "name", value: name)]
        }
    }
}

// MARK: Door

struct Door: Decodable {
    let id: Int
    let name: String
    let serial: String
    let lockMac: String
    let battery: Int
    let address: String
    let longitude: Double
    let latitude: Double
}

// MARK: Doors List

struct DoorsListResponse: Decodable {
    let content: [Door]
    
    let page: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
    let last: Bool
}

// Wrong call from POSTMAN
struct DoorsPagination: Decodable {
    let number: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
}

// MARK: Door Search

struct DoorSearchResponse: Decodable {
    let door: Door
}

struct DoorsError: Decodable, Error {
    let code: String
    let description: String

    static var standardError: DoorsError {
        DoorsError(code: "unknown", description: "An unknown error occurred.")
    }
}

