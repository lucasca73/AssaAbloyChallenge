//
//  AuthService.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import Foundation

protocol LoginService {
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol SignUpService {
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class NetworkService {
    
}

extension NetworkService: LoginService {
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(.success(true))
        }
    }
}

extension NetworkService: SignUpService {
    func signUp(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(.success(true))
        }
    }
}
