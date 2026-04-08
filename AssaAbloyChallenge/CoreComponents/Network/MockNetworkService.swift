//
//  MockNetworkService.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

class MockNetworkService: NetworkService {}

extension MockNetworkService: LoginService {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(.success(LoginResponse(token: "123ThisIsFake")))
        }
    }
}

extension MockNetworkService: SignUpService {
    func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignupResponse, SignupError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(.success(SignupResponse(id: 1, firstName: "Jorge", lastName: "Washington", email: "email@email.br")))
        }
    }
}

extension MockNetworkService: DoorsFetchService {
    func fetchDoors(completion: @escaping (Result<[DoorModel], any Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            
            let doors = [
                DoorModel(id: 1, isOpen: true, name: "Door 1", lastOpened: .now, lastClosed: .now - 100000),
                DoorModel(id: 2, isOpen: true, name: "Backyard Door", lastOpened: .now, lastClosed: .now - 200000),
                DoorModel(id: 3, isOpen: false, name: "Frontdoor", lastOpened: .now - 300000, lastClosed: .now)
            ]
            
            completion(.success(doors))
        }
    }
}
