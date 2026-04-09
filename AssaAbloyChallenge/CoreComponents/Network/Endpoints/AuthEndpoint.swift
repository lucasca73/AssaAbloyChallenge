//
//  AuthEndpoint.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

enum AuthEndpoint: Endpoint {
    case login(email: String, password: String)
    case signup(firstName: String, lastName: String, email: String, password: String)

    var path: String {
        switch self {
        case .login: return "/users/signin"
        case .signup: return "/users/signup"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .signup: return .post
        }
    }
    
    var body: (any Encodable)? {
        switch self {
        case let .login(email, password):
            return LoginRequest(email: email, password: password)
        case let .signup(firstName, lastName, email, password):
            return SignupRequest(firstName: firstName, lastName: lastName, email: email, password: password)
        }
    }
    
    var authNeeded: Bool { false }
    var headers: [String : String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
}

// MARK: Login

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let token: String
}

struct LoginError: Decodable, Error {
    let code: String
    let description: String
    
    static var standardError: LoginError {
        LoginError(code: "unknown", description: "An unknown error occurred.")
    }
}

// MARK: Signup

struct SignupRequest: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}

struct SignupResponse: Decodable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let createdAt: String
}

struct SignupError: Decodable, Error {
    let code: String
    let description: String
    let fieldErrors: [SignupFieldError]
    
    static var standardError: SignupError {
        SignupError(code: "unknown", description: "An unknown error occurred.", fieldErrors: [])
    }
}

struct SignupFieldError: Decodable {
    let field: String
    let message: String
}
