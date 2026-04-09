//
//  MockNetworkService.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 08/04/26.
//

import Foundation

class MockNetworkService: NetworkService {
    var isAuthenticated: Bool = false
    
}

extension MockNetworkService: LoginService {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.isAuthenticated = true
            completion(.success(LoginResponse(token: "123ThisIsFake")))
        }
    }
}

extension MockNetworkService: SignUpService {
    func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignupResponse, SignupError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            completion(.success(SignupResponse(id: "1", firstName: "Jorge", lastName: "Washington", email: "email@email.br", createdAt: "")))
        }
    }
}

extension MockNetworkService: DoorsFetchService {
    func fetchDoors(page: Int, size: Int, completion: @escaping (Result<DoorsListResponse, DoorsError>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            
            let doors = [Door(id: 1, name: "Door", serial: "", lockMac: "", battery: 99, address: "", longitude: 0.00, latitude: 0.00)]
            
            completion(.success(DoorsListResponse(content: doors, page: 0, size: 5, totalElements: 1, totalPages: 1, last: true)))
        }
    }
}
