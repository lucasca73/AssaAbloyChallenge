//
//  NetworkServiceProtocol.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable, E: Decodable>(_ endpoint: Endpoint) async throws -> Result<T, E>
}

protocol LoginService {
    var isAuthenticated: Bool { get }
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> Void)
}

protocol SignUpService {
    func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignupResponse, SignupError>) -> Void)
}

protocol DoorsFetchService {
    func fetchDoors(page: Int, size: Int, completion: @escaping (Result<DoorsListResponse, DoorsError>) -> Void)
}
