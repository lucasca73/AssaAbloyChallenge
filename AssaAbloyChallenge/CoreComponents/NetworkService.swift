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

protocol DoorsFetchService {
    func fetchDoors(completion: @escaping (Result<[DoorModel], Error>) -> Void)
}

class NetworkService {}

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

extension NetworkService: DoorsFetchService {
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
