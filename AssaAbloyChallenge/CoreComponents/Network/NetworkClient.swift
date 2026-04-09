//
//  AuthService.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import Foundation

protocol NetworkService: LoginService, SignUpService, DoorsFetchService { }

class NetworkClient: NetworkService {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let keychainManager: KeychainManager
    
    var forcedLogoutCallback: (() -> Void)?
    
    var isAuthenticated: Bool {
        (try? keychainManager.read(for: KeychainKey.accessToken)) != nil
    }

    init(keychainManager: KeychainManager = KeychainManager(), session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        self.keychainManager = keychainManager
    }
    
    func logout() {
        Task { @MainActor [weak self] in
            try? self?.keychainManager.delete(for: KeychainKey.accessToken)
        }
    }
    
    func forceLogout() {
        logout()
        forcedLogoutCallback?()
    }

    func request<T: Decodable, E: Decodable>(_ endpoint: Endpoint) async throws -> Result<T, E> {
        let request: URLRequest
        
        if endpoint.authNeeded {
            let token = try? keychainManager.read(for: KeychainKey.accessToken)
            request = try endpoint.urlRequest(token: token)
        } else {
            request = try endpoint.urlRequest()
        }
    
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            do {
                if httpResponse.statusCode == 401 {
                    self.forceLogout()
                }
                return .failure(try decoder.decode(E.self, from: data))
            } catch {
                throw NetworkError.decoding(error)
            }
        }

        do {
            return .success(try decoder.decode(T.self, from: data))
        } catch {
            debugPrint("failed to decode: \(String(describing: String(data: data, encoding: .utf8)))")
            throw NetworkError.decoding(error)
        }
    }
}

extension NetworkClient: LoginService {
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, LoginError>) -> Void) {
        Task { [weak self] in
            guard let self else { return }
            do {
                let result: Result<LoginResponse, LoginError> = try await self.request(AuthEndpoint.login(email: email, password: password))
                switch result {
                case .success(let response):
                    try self.keychainManager.save(response.token, for: KeychainKey.accessToken)
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(LoginError.standardError))
            }
        }
    }
}

extension NetworkClient: SignUpService {
    func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Result<SignupResponse, SignupError>) -> Void) {
        Task {
            do {
                let result: Result<SignupResponse, SignupError> = try await self.request(AuthEndpoint.signup(firstName: firstName, lastName: lastName, email: email, password: password))
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(SignupError.standardError))
            }
        }
    }
}

extension NetworkClient: DoorsFetchService {
    func fetchDoors(page: Int, size: Int, completion: @escaping (Result<DoorsListResponse, DoorsError>) -> Void) {
        Task {
            do {
                let result: Result<DoorsListResponse, DoorsError> = try await self.request(DoorsEndpoint.list(page: page, size: size))
                switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(DoorsError.standardError))
            }
        }
    }
}
