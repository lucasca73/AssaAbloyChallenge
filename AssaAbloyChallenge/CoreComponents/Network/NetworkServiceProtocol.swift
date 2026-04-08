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
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> Void)
}

protocol SignUpService {
    func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignupResponse, SignupError>) -> Void)
}

protocol DoorsFetchService {
    func fetchDoors(completion: @escaping (Result<[DoorModel], Error>) -> Void)
}
