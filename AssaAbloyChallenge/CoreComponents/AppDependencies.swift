//
//  AppDependencies.swift
//  AssaAbloyChallenge
//
//  Created by Lucas Costa Araujo on 07/04/26.
//

import Foundation

// Container to inject dependencies on ViewModels
class AppDependencies {
    var networkService: NetworkService
    var appConfig: AppConfig
    
    init(networkService: NetworkService = NetworkClient(), appConfig: AppConfig = .current) {
        self.networkService = networkService
        self.appConfig = appConfig
    }
}
